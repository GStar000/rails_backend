class AddCommentToSpreeOptionTypes < ActiveRecord::Migration
  def change
    add_column :spree_option_types, :comment, :boolean, default: false
  end
end
