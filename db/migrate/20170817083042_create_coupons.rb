class CreateCoupons < ActiveRecord::Migration
  # def change
  #   create_table :coupons do |t|
  #     t.string :name
  #     t.string :description

  #     t.timestamps null: false
  #   end
  # end

  def up
    create_table :coupons do |t|
      t.string :name
      t.string :description
      t.timestamps
    end
  end

  def down
    drop_table :coupons
  end
  
end
