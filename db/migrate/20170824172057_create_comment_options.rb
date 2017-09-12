class CreateCommentOptions < ActiveRecord::Migration
  def change
    create_table :comment_options do |t|
      t.string :name
      t.string :presentation

      t.timestamps null: true
    end
  end
end
