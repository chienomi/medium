class AddAttachmentImageC4ToDemos < ActiveRecord::Migration
  def self.up
    change_table :demos do |t|
      t.attachment :image_c4
    end
  end

  def self.down
    remove_attachment :demos, :image_c4
  end
end
