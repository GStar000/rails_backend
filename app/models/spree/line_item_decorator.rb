module Spree
  LineItem.class_eval do
    # attr_accessible :variants
    # serialize :variants, Array
    # has_many :variants, class_name: "Spree::Variant"
    has_many :order_infos
  end
end
