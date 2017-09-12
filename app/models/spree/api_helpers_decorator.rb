Spree::Api::ApiHelpers.class_eval do
  class_variable_set(:@@product_attributes, class_variable_get(:@@product_attributes).push(:file_up_load))
  #Add description and option case to option type
  class_variable_set(:@@option_type_attributes, class_variable_get(:@@option_type_attributes).push(:description))
  class_variable_set(:@@option_type_attributes, class_variable_get(:@@option_type_attributes).push(:spree_option_case_id))
  
  class_variable_set(:@@product_attributes, class_variable_get(:@@product_attributes).push(:spree_product_variant_types))
  class_variable_set(:@@variant_attributes, class_variable_get(:@@variant_attributes).push(:order_info_id))
  class_variable_set(:@@line_item_attributes, class_variable_get(:@@line_item_attributes).push(:order_infos))
  class_variable_set(:@@option_value_attributes, class_variable_get(:@@option_value_attributes).push(:image))
  # @@product_variant_type_attributes = [:name, :presentation, :product_variant_value_attributes]
  # @@product_variant_value_attributes = [:name, :presentation, :price]
end