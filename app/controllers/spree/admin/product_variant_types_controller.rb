module Spree
    module Admin
        class ProductVariantTypesController < ResourceController
            belongs_to 'spree/product', find_by: :slug
            after_action :update_variants, only: [:update]

            def update_variants
                
                @product.variants.each do |variant|
                    if variant.option_values.length == 1
                        price = 0
                        variant.option_values.each do |value|
                            @product.product_variant_values.each do |vv|
                                if value.name == vv.name
                                    price += vv.price
                                end
                            end
                        end
                        variant.price = price
                        variant.save
                    end
                end
            end

            def product_variant_type_params
                params.require(:product_variant_type).permit(permitted_product_variant_type_attributes)
            end
        end
    end
end
