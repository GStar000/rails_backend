class CreateSpreeOrderInfoOptions < ActiveRecord::Migration
  def change
    create_table :spree_order_info_options do |t|
      t.string :name
      t.string :presentation
      t.string :description

      t.timestamps null: false
    end
  end
end
