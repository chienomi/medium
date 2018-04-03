class AddAttachmentDemoImgToDemos < ActiveRecord::Migration
  def self.up
    change_table :demos do |t|
      t.attachment :demo_img
    end
  end

  def self.down
    remove_attachment :demos, :demo_img
  end
end
