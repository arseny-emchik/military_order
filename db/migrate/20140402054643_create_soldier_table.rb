class CreateSoldierTable < ActiveRecord::Migration
  def change
    create_table :soldiers do |t|
      t.string :surname, null: false
      t.string :name, null: false
      t.string :patronymic, null: false
    end
  end
end
