class CreateSpreeOptionCases < ActiveRecord::Migration
  def change
    create_table :spree_option_cases do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
