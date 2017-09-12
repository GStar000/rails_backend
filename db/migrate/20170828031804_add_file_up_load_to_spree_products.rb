class AddFileUpLoadToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :file_up_load, :boolean, default: false
  end
end