class AddBiosToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio, :string, index: true, default: ""
    add_column :users, :twitter, :string, index: true, default: ""
    add_column :users, :facebook, :string, index: true, default: ""
    add_column :users, :youtube, :string, index: true, default: ""
    add_column :users, :soundcloud, :string, index: true, default: ""
    add_column :users, :deviantart, :string, index: true, default: ""
    add_column :users, :pixiv, :string, index: true, default: ""
  end
end
