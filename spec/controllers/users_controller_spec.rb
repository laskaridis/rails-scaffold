describe UsersController do

  describe 'GET #new' do
    before { get :new }

    it { should respond_with :success }
    it { should render_template :new }
    it { should_not set_flash }
  end

  describe 'POST #create' do

    context 'with valid attributes' do
      before do
        user_attributes = FactoryGirl.attributes_for(:user)
        post :create, user: user_attributes
      end

      it 'redirects to storefront url' do
        expect(response).to redirect_to storefront_url
      end

      it 'logs user' do
        expect(controller).to be_logged_in
      end

      it 'sets current user' do
        expect(controller.current_user).to be_present
      end
    end

    context 'with invalid attributes' do
      before { post :create }

      it 'renders registration page' do
        expect(response).to render_template(:new)
      end

      it 'should not log user' do
        expect(controller).to be_logged_out
      end

      it 'should not set the current user' do
        expect(controller.current_user).to be_nil
      end
    end
  end
end
