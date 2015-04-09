
def login
  login_as create(:user)
end

def login_as(user)
  @controller.login user
end

def logout
  @controller.logout
end
