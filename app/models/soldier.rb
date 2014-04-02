class Soldier < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :patrol, dependent: :destroy
  has_one :rank
end