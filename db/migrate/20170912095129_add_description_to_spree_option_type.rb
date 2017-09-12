class AddDescriptionToSpreeOptionType < ActiveRecord::Migration
  def change
    add_column :spree_option_types, :description, :string
  end
end
