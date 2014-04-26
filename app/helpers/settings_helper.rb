module SettingsHelper
  def define_role(user)
    return 'admin' if user.admin?
    return 'читатель' if user.member?
    'ожидает проверки'
  end

  def users(registered)
    registered ? User.all_available.registered : User.all_available.not_registered
  end

  def email_or_name(user)
     user.name.nil? || user.name.empty? ? user.email : user.name
  end
end