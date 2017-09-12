# module Spree
#     Order.class_eval do
#         def line_item_variants_match(line_item, variants = {})
#             return true unless variants
#             Rails.logger.warn"------------------------------------------#{line_item.variants.all? {|x| variants.include?(x)}}, #{line_item.variants}, #{variants} --------------------------------------"
#             return line_item.variants.all? {|x| variants.include?(x)}
#             # line_item_comparison_hooks.all? do |hook|
#             #     send(hook, line_item, variants)
#             # end
#         end

#         def find_line_item_by_variant(variant, options = {}, variants = {})
#             line_items.detect do |line_item|
#                 Rails.logger.warn"-------------------line_item-----------------------#{line_item.variants} --------------------------------------"
#                 line_item.variant_id == variant.id && 
#                     line_item_options_match(line_item, options) &&
#                         line_item_variants_match(line_item, variants)
#             end
#         end
#     end
# end
