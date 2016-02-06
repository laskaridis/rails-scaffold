
describe 'routes for users' do

  it { expect(get: 'users').to_not be_routable }
  it { expect(post: 'users').to be_routable }
  it { expect(put: 'users').to be_routable }
  it { expect(delete: 'users/1').to be_routable }
  it { expect(get: '/register').to be_routable }
  it { expect(get: '/users/verify').to be_routable }
  it { expect(get: '/users/edit').to be_routable }
end
