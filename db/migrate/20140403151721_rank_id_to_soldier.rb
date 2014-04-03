class RankIdToSoldier < ActiveRecord::Migration
  def change
    change_table :soldiers do |t|
      t.belongs_to :rank
    end
  end
end
