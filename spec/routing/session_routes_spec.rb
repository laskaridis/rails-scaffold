
describe "routes for sessions" do

  it { expect(get '/login').to be_routable }
  it { expect(get '/logout').to be_routable }
  it { expect(post '/session').to be_routable }
end
