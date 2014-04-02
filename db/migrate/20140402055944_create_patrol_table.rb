class CreatePatrolTable < ActiveRecord::Migration
  def change
    create_table :patrols do |t|
      t.date :patrol_start, null: false
      t.date :patrol_end, null: false
      t.timestamps
    end
  end
end
