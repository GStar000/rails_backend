module Spree
    class OrderInfo < Spree::Base
        has_many :spree_variants
        belongs_to :spree_line_items
    end
end