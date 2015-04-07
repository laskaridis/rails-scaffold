
describe 'routes for users', type: :routing do

  it { expect(get: 'users').to_not be_routable }
  it { expect(post: 'users').to be_routable }
  it { expect(get: 'users/1').to be_routable }
  it { expect(get: 'users/1/edit').to be_routable }
  it { expect(patch: 'users/1').to be_routable }
  it { expect(put: 'users/1').to be_routable }
  it { expect(delete: 'users/1').to be_routable }
  it { expect(get: '/register').to be_routable }
end
