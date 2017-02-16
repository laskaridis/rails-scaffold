
describe 'routes for users' do

  it { expect(get: 'user').to_not be_routable }
  it { expect(post: 'user').to_not be_routable }
  it { expect(put: 'user').to be_routable }
  it { expect(get: '/register').to be_routable }
  it { expect(get: '/user/verify').to be_routable }
  it { expect(get: '/user/edit').to be_routable }
  it { expect(put: '/user/profile').to be_routable }
  it { expect(put: '/user/settings').to be_routable }
  it { expect(put: '/user/preferences').to be_routable }
end
