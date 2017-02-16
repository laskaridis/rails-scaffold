
describe 'routes for messages' do

  it { expect(get: '/user/messages').to be_routable }
  it { expect(get: '/user/messages/:id').to be_routable }
  it { expect(delete: '/user/messages/:id').to be_routable }
  it { expect(post: '/user/messages').to be_routable }
end
