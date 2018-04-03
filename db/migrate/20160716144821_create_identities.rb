class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid
      t.string :provider
      t.string :urls
      # t.string :user_name
      # t.string :email,              null: false, default: ""
      # t.string :encrypted_password, null: false, default: ""
      # t.attachment :image_user
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end