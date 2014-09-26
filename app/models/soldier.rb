class Soldier < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :patrol, dependent: :destroy
  belongs_to :rank

  validates :surname, :name, :patronymic, :rank_id, presence: {message: 'Поле не может быть пустым'}


  def self.sort_by_patrols(date_start, date_end,  sort = 'desc')
    # # @patrols = Patrol.where('patrol_end >= :start AND patrol_end <= :end', start: date_start, end: date_end)
    # Soldier
    #     .joins('LEFT JOIN patrols ON soldiers.id = patrols.soldier_id')
    #     .where('patrol_end >= :start AND patrol_end <= :end', start: date_start, end: date_end)
    #     .joins('RIGHT JOIN soldiers as s ON s.id = patrols.soldier_id')
    #     .group('soldiers.id')
    # # Soldier.includes(@patrols)
    # # Soldier.includes(:patrol).group('soldiers.id').reverse!
    # # Soldier.find_by_sql("select s.id, s.name, s.surname, s.patronymic, s.rank_id, count(*) as c from soldiers as s
    # #                       left join patrols as p on s.id = p.soldier_id
    # #                       group by s.id, s.name, s.surname, s.patronymic, s.rank_id
    # #                       order by c #{sort}")

    # temp not working
    Soldier.all
  end
end
