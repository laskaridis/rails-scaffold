
def login
  login_as create(:user)
end

def login_as(user)
  @controller.login user
  user
end

def logout
  @controller.logout
end
