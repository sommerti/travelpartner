class AddDeleteAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :delete_avatar, :boolean
  end
end
