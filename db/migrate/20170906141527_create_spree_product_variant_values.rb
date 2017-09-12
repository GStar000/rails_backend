class CreateSpreeProductVariantValues < ActiveRecord::Migration
  def change
    create_table :spree_product_variant_values do |t|
      t.string :name
      t.string :presentation
      t.float :price,  default: 0
      t.integer :product_id
      t.integer :product_variant_type_id

      t.timestamps null: false
    end
  end
end
