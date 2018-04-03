class AddAttachmentThumbDToDemos < ActiveRecord::Migration
  def self.up
    change_table :demos do |t|
      t.attachment :thumb_d
    end
  end

  def self.down
    remove_attachment :demos, :thumb_d
  end
end
