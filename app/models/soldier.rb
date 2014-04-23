class Soldier < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :patrol, dependent: :destroy
  belongs_to :rank

  validates :surname, :name, :patronymic, :rank_id, presence: {message: 'Поле не может быть пустым'}


  def self.sort_by_patrols(sort = 'desc')
    Soldier.find_by_sql("select s.id, s.name, s.surname, s.patronymic, s.rank_id, count(*) as c from soldiers as s
                          join patrols as p on s.id = p.soldier_id
                          group by s.id, s.name, s.surname, s.patronymic, s.rank_id
                          order by c #{sort}")
  end
end