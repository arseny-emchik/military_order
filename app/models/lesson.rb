class Lesson < ActiveRecord::Base
  belongs_to :soldier
  validates :hours, numericality: true
end