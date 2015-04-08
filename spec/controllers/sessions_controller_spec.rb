
describe SessionsController do

  describe "GET #new" do
    before { get :new }

    it { should respond_with(:success) }
    it { should render_template(:new) }
    it { should_not set_flash }
  end

  describe "POST #create" do

    context 'with invalid email' do
      before { post :create, session: { email: 'invalid', password: 'password' } }

      it 'renders login page with error' do
        expect(response).to render_template(:new)
        expect(flash[:error]).to eq I18n.t('errors.login')
      end

      it 'should not set the user in session' do
        expect(controller.current_user).to be_nil
      end

      it 'should not log user' do
        expect(controller).to be_logged_out
        expect(controller).to_not be_logged_in
      end
    end

    context 'with valid credentials' do
      before do
        @user = create(:user)
        post :create, session: { email: @user.email, password: @user.password }
      end

      it 'sets the user in session' do
        expect(controller.current_user).to eq @user
      end

      it 'logs user' do
        expect(controller).to be_logged_in
        expect(controller).to_not be_logged_out
      end

      it 'redirects to storefront page' do
        should redirect_to storefront_url
      end
    end
  end
end
