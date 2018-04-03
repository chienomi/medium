class AddAttachmentFileExeTryToDemos < ActiveRecord::Migration
  def self.up
    change_table :demos do |t|
      t.attachment :file_exe_try
    end
  end

  def self.down
    remove_attachment :demos, :file_exe_try
  end
end
