class AddSpreeOptionCaseToSpreeOptionType < ActiveRecord::Migration
  def change
    add_reference :spree_option_types, :spree_option_case, index: true, foreign_key: true
  end
end
