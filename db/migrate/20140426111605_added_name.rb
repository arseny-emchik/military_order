class AddedName < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, null: true
  end
end
