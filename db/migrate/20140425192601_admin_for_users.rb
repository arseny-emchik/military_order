class AdminForUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :member, :boolean, default: false
  end
end
