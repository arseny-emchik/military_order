class KindPatrol < ActiveRecord::Migration
  def change
    add_column :patrols, :kind, :string, limit: 1, null: false, default: 'ф'
  end
end
