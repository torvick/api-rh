class AuthenticateUserService
  def initialize(params)
    @email    = params[:email]
    @password = params[:password]
  end

  # Public interface
  def self.authenticate(*args)
    new(*args).authenticate!
  end

  def authenticate!
    user = User.find_by(email: @email)
    if user && @password
      user if user.valid_password?(@password)
    else
      false
    end
  end
end
