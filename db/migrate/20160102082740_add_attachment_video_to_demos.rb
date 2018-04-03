class AddAttachmentVideoToDemos < ActiveRecord::Migration
  def self.up
    change_table :demos do |t|
      t.attachment :video
    end
  end

  def self.down
    remove_attachment :demos, :video
  end
end
