class CreateSpreeOrderInfos < ActiveRecord::Migration
  def change
    create_table :spree_order_infos do |t|
      t.string :context
      t.float :price
      t.integer :line_item_id

      t.timestamps null: false
    end
  end
end
