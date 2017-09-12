module Spree
    module Admin
        class ProductVariantValuesController < ResourceController
            

            def product_variant_value_params
                params.require(:product_variant_value).permit(permitted_product_variant_value_attributes)
            end
        end
    end
end
