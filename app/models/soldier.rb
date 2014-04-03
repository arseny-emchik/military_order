class Soldier < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :patrol, dependent: :destroy
  belongs_to :rank
end