module Spree
    class ProductVariantType < Spree::Base
        belongs_to :spree_products, :foreign_key => 'product_id'
        has_many :product_variant_values

        accepts_nested_attributes_for :product_variant_values, allow_destroy: true
    end
end
