module Spree
    Variant.class_eval do
        belongs_to :order_infos
    end
end
