module CurrentUser
  class << self
    attr_accessor :session

    def record
      return nil unless session[:user_id].present?
      User.find_by id: session[:user_id]
    end

    def type
      UserTypes.type_for record
    end

    def log_in user
      self.session[:user_id] = user.id
    end

    def log_out
      reset_session
    end

    # type check methods per user type
    # e.g.:
    #  CurrentUser.none?
    #  CurrentUser.admin?
    UserTypes.types.each do |user_type|
      define_method "#{user_type}?" do
        type == user_type
      end
    end
  end
end
