class Spree::Admin::OrderInfoOptionsController < Spree::Admin::ResourceController
    before_action :setup_new_option_value, only: :edit

    def update_values_positions
        ApplicationRecord.transaction do
            params[:positions].each do |id, index|
            Spree::OptionValue.where(id: id).update_all(position: index)
            end
        end

        respond_to do |format|
            format.html { redirect_to admin_product_variants_url(params[:product_id]) }
            format.js { render plain: 'Ok' }
        end
    end

    protected

    def location_after_save
        if @order_info_option.created_at == @order_info_option.updated_at
        edit_admin_option_type_url(@order_info_option)
        else
        admin_order_info_option_url
        end
    end

    private
    def setup_new_option_value
        # @order_info_option.option_values.build if @order_info_option.option_values.empty?
    end
end
