
describe 'routes for users' do

  it { expect(get: '/register').to be_routable }
  it { expect(get: '/user/verify').to be_routable }
  it { expect(get: '/user/profile').to be_routable }
  it { expect(put: '/user/profile').to be_routable }
  it { expect(get: '/user/settings').to be_routable }
  it { expect(put: '/user/settings').to be_routable }
  it { expect(get: '/user/preferences').to be_routable }
  it { expect(put: '/user/preferences').to be_routable }
end
