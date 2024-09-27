class AdminPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    return false unless @user
    @user.role == "ADMIN"
  end

  def user_management?
    return false unless @user
    @user.role == "ADMIN"
  end

  def activity?
    return false unless @user
    @user.role == "ADMIN"
  end
end
