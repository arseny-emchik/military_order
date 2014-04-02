class CreateRankTable < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :title, null: false
    end
  end
end
