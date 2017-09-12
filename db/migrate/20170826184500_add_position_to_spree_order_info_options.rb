class AddPositionToSpreeOrderInfoOptions < ActiveRecord::Migration
  def change
    add_column :spree_order_info_options, :position, :integer
  end
end
