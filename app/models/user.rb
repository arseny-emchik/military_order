class User < ActiveRecord::Base
  before_save :set_roles

  devise :database_authenticatable, :validatable, :rememberable, :registerable, :trackable

  def set_roles
    self.admin = true if self.super_admin?
    self.member = true if self.admin?
  end

  class << self
    def all_available
      self.where(super_admin: false)
    end

    def registered
      self.where(member: true)
    end

    def not_registered
      self.where(member: false)
    end
  end
end
