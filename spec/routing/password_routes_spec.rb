
describe 'routes for passwords' do

  it { expect(get: 'passwords/new').to be_routable }
  it { expect(post: 'passwords').to be_routable }
  it { expect(get: 'passwords/1/edit').to be_routable }
  it { expect(put: 'passwords/1').to be_routable }
end
