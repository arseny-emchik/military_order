class Lesson < ActiveRecord::Base
  belongs_to :soldier
  validates :hours, numericality: true,
            inclusion: {in: 1..9, message: 'Только числа от 1 до 99'},
            presence: {message: 'Поле не может быть пустым'}
end