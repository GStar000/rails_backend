class AddOrderInfoIdToSpreeVariant < ActiveRecord::Migration
  def change
    add_column :spree_variants, :order_info_id, :integer
  end
end
