
Spree::Admin::ProductsController.class_eval do

    def update
        if params[:product][:taxon_ids].present?
            params[:product][:taxon_ids] = params[:product][:taxon_ids].split(',')
        end
        if params[:product][:option_type_ids].present?
            params[:product][:option_type_ids] = params[:product][:option_type_ids].split(',')
        end
        # if params[:product][:order_info_option_ids].present?
        #     params[:product][:order_info_option_ids] = params[:product][:order_info_option_ids].split(',')
        # end    

        invoke_callbacks(:update, :before)

        if @object.update_attributes(permitted_resource_params)
            invoke_callbacks(:update, :after)
            flash[:success] = flash_message_for(@object, :successfully_updated)
            Rails.logger.warn "--------------------------------------#{type_updated?}-----------------------------"
            if type_updated?
                Rails.logger.warn "-------------------Length---#{@object.product_variant_types.length}---------------------"
                create_product_variant_values_for_types
                Rails.logger.warn "-------------------Length---#{@object.product_variant_types.length}---------------------"
                @object.variants.clear
                create_variants_for_product
            end

            respond_with(@object) do |format|
                format.html { redirect_to location_after_save }
                format.js   { render layout: false }
            end
        else
            # Stops people submitting blank slugs, causing errors when they try to
            # update the product again
            @product.slug = @product.slug_was if @product.slug.blank?
            invoke_callbacks(:update, :fails)
            respond_with(@object)
        end

    end

    def type_updated?

        i = 0
        @object.option_types.each do |ot|
            if ot.spree_option_case_id == 1

                if @object.product_variant_types[i] == nil
                    return true
                end

                if ot.name != @object.product_variant_types[i].name 
                    return true
                end

                i = i + 1
            end
        end

        if i != @object.product_variant_types.length
            return true
        else
            return false
        end
    end

    def create_variants_for_product

        variant = @product.variants.build
        variant.price = @product.price

        @object.option_types.each do |ot|
            ot.option_values.each do |ov|
                variant.option_values << ov
            end
        end
        
        @object.variants << variant

        @object.option_types.each do |ot|
            ot.option_values.each do |ov|
                variant = @product.variants.build
                variant.option_values << ov
                variant.price = 0
                @object.variants << variant
            end
        end
    end

    def create_product_variant_values_for_types
        @object.product_variant_types.clear
        @object.product_variant_values.clear

        @object.option_types.each do |ot|
            if ot.spree_option_case_id == 1
                
                vt = @product.product_variant_types.build
                vt.name = ot.name
                vt.presentation = ot.presentation

                ot.option_values.each do |ov|
                    vv = @product.product_variant_values.build
                    vv.name = ov.name
                    vv.presentation = ov.presentation

                    vt.product_variant_values << vv
                end
                @object.product_variant_types << vt
            end
        end
    end

 end
