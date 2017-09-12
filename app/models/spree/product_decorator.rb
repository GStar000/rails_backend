module Spree
    Product.class_eval do

        has_many :product_variant_types
        has_many :product_variant_values

        def empty_option_values?
            options.empty? || options.any? do |opt|
                opt.option_type.option_values.empty? && opt.option_type.spree_option_case_id == 1
            end
        end
    end
end