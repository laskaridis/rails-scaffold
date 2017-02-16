
describe 'routes for accounts' do

  it { expect(get: 'user/account').to be_routable }
  it { expect(put: 'user/account/change_password').to be_routable }
end
