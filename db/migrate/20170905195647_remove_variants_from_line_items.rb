class RemoveVariantsFromLineItems < ActiveRecord::Migration
  def change
    remove_column :spree_line_items, :variants, :integer
  end
end
