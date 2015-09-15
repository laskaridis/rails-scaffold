
describe 'routes for accounts' do

  it { expect(get: 'account').to be_routable }
  it { expect(put: 'account/change_password').to be_routable }
end
