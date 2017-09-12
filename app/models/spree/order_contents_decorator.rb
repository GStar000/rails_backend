module Spree
    OrderContents.class_eval do

        def add_to_line_item(variant, quantity, options = {})

        
            # line_item = grab_line_item_by_variant(variant, false, options, variants)
            # if line_item
            #     line_item.quantity += quantity.to_i
            #     line_item.currency = currency unless currency.nil?
            #     
            # else
            Rails.logger.warn "pass---------------------------------------------------------------"
                options_params = options.is_a?(ActionController::Parameters) ? options : ActionController::Parameters.new(options.to_h)
                opts = options_params.
                    permit(PermittedAttributes.line_item_attributes).to_h.
                    merge( { currency: order.currency } )
                line_item = order.line_items.new(quantity: quantity,
                                                variant: variant,
                                                options: opts)
            # end

            # variants.each do |x|
            #     line_item.variants << x
            # end

            line_item.target_shipment = options[:shipment] if options.has_key? :shipment
            line_item.save!
            line_item
        end

    end
end