module SpecTestHelper   
  def login_admin
    user = create(:user, admin: true)
    login user
  end

  def login(user)
    # user = User.where(:login => user.to_s).first if user.is_a?(Symbol)
    # user = User.where(admin: true) if user.to_s == 'admin'
    request.session[:user_id] = user.id
  end

  def current_user
    User.find(request.session[:user_id])
  end
end