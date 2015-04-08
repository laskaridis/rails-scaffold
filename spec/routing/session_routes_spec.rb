

describe "routes for sessions", type: :routing do

  it { expect(get '/login').to be_routable }
  it { expect(delete '/logout').to be_routable }
  it { expect(post '/session').to be_routable }
end
