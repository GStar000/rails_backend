Spree::Core::Importer::Order.class_eval do

    def import(user, params)
      begin
        ensure_country_id_from_params params[:ship_address_attributes]
        ensure_state_id_from_params params[:ship_address_attributes]
        ensure_country_id_from_params params[:bill_address_attributes]
        ensure_state_id_from_params params[:bill_address_attributes]

        create_params = params.slice :currency
        order = Spree::Order.create! create_params
        order.associate_user!(user)

        shipments_attrs = params.delete(:shipments_attributes)

        create_line_items_from_params(params.delete(:line_items_attributes),order)
        create_shipments_from_params(shipments_attrs, order)
        create_adjustments_from_params(params.delete(:adjustments_attributes), order)
        create_payments_from_params(params.delete(:payments_attributes), order)

        if completed_at = params.delete(:completed_at)
          order.completed_at = completed_at
          order.state = 'complete'
        end

        params.delete(:user_id) unless user.try(:has_spree_role?, "admin") && params.key?(:user_id)

        order.update_attributes!(params)

        order.create_proposed_shipments unless shipments_attrs.present?

        # Really ensure that the order totals & states are correct
        order.updater.update
        if shipments_attrs.present?
          order.shipments.each_with_index do |shipment, index|
            shipment.update_columns(cost: shipments_attrs[index][:cost].to_f) if shipments_attrs[index][:cost].present?
          end
        end
        order.reload
      rescue Exception => er
        order.destroy if order && order.persisted?
        raise e.message
      end
    end

    def self.create_line_items_from_params(line_items, order)
        return {} unless line_items
        iterator = case line_items
        when Hash
            ActiveSupport::Deprecation.warn(<<-EOS, caller)
              Passing a hash is now deprecated and will be removed in Spree 4.0.
              It is recommended that you pass it as an array instead.

              New Syntax:

              {
                "order": {
                  "line_items": [
                    { "variant_id": 123, "quantity": 1 },
                    { "variant_id": 456, "quantity": 1 }
                  ]
                }
              }

              Old Syntax:

              {
                "order": {
                  "line_items": {
                    "1": { "variant_id": 123, "quantity": 1 },
                    "2": { "variant_id": 123, "quantity": 1 }
                  }
                }
              }
            EOS
            :each_value
        when Array
            :each
        end

        line_items.send(iterator) do |line_item|
            begin
              adjustments = line_item.delete(:adjustments_attributes)
              extra_params = line_item.except(:variant_id, :quantity, :sku)
              line_item = ensure_variant_id_from_params(line_item)
              variant = Spree::Variant.find(line_item[:variant_id])
              line_item = order.contents.add(variant, line_item[:quantity])
              # Raise any errors with saving to prevent import succeeding with line items
              # failing silently.
              if extra_params.present?
                line_item.update_attributes!(extra_params)
              else
                line_item.save!
              end
              create_adjustments_from_params(adjustments, order, line_item)
            rescue Exception => e
              raise "Order import line items: #{e.message} #{line_item}"
            end
        end
    end


end

