module Routes

  class LoggedInConstraint
    def matches?(request)
      request.env['warden'].authenticated?(:user)
    end
  end

end
