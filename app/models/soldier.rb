class Soldier < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :patrol, dependent: :destroy
  belongs_to :rank

  validates :surname, :name, :patronymic, :rank_id, presence: {message: 'Поле не может быть пустым'}
end