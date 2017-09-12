module Spree
    class ProductVariantValue < Spree::Base
        belongs_to :spree_products, :foreign_key => 'product_id'
        belongs_to :product_variant_type, touch: true

        delegate :name, :presentation, to: :product_variant_type, prefix: true, allow_nil: true

        self.whitelisted_ransackable_attributes = ['presentation']
    end
end
