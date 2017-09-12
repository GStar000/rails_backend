class AddOrderInfoOptionIdsToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :order_info_option_ids, :text, array:true
  end
end
