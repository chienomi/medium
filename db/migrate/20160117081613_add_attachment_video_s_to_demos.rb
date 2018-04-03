class AddAttachmentVideoSToDemos < ActiveRecord::Migration
  def self.up
    change_table :demos do |t|
      t.attachment :video_s
    end
  end

  def self.down
    remove_attachment :demos, :video_s
  end
end
