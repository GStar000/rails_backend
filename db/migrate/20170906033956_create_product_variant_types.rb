class CreateProductVariantTypes < ActiveRecord::Migration
  def change
    create_table :product_variant_types do |t|
      t.string :name
      t.string :presentation
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
