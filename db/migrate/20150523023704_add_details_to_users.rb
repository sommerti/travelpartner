class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :about, :text
    add_column :users, :slug, :string
  end
end
