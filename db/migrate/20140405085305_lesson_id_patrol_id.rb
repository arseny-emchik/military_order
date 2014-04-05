class LessonIdPatrolId < ActiveRecord::Migration
  def change
      change_table :lessons do |t|
        t.belongs_to :soldier
      end

      change_table :patrols do |t|
        t.belongs_to :soldier
      end
  end
end
