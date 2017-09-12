class AddAttachmentImageToSpreeOptionValues < ActiveRecord::Migration
  def self.up
    change_table :spree_option_values do |t|
      t.attachment :image
    end
  end
  
  def self.down
    remove_attachment :spree_option_values, :image
  end
end
