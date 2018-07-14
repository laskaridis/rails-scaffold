
def login
  login_as create(:user)
end

def login_as(user)
  sign_in user
  return user
end

def logout
  sign_out
end
