class CreateLessonTable < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :hours, null: false
      t.date :date, null: false
    end
  end
end
