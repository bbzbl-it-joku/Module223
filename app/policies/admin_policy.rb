class AdminPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.role == "ADMIN"
  end

  def user_management?
    @user.role == "ADMIN"
  end

  def activity?
    @user.role == "ADMIN"
  end
end
