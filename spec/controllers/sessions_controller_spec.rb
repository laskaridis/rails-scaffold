describe SessionsController do

  describe "GET #new" do

    context 'when user is logged in' do
      before { get :new }

      it { should respond_with(:success) }
      it { should render_template(:new) }
      it { should_not set_flash }
    end

    context 'when user is logged in' do
      before do
        login
        get :new
      end

      it { should redirect_to root_url }
      it { should_not set_flash }
    end
  end

  describe "POST #create" do

    context 'with invalid email' do
      before { post :create, params: { session: { email: 'invalid', password: 'password' } } }

      it 'should not log user' do
        expect(response).to render_template(:new)
        expect(flash[:error]).to eq I18n.t('errors.login')
        expect(controller.current_user).to be_nil
        expect(controller).to be_logged_out
        expect(controller).to_not be_logged_in
      end
    end

    context 'given a user pending verification' do
      before do
        @user = create(:user)
        post :create, params: { session: { email: @user.email, password: @user.password } }
      end

      it 'should not log user' do
        expect(flash[:error]).to eq I18n.t('errors.verify_email.pending')
        expect(controller.current_user).to be_nil
        expect(controller).to be_logged_out
        expect(controller).to_not be_logged_in
      end
    end

    context 'given a verified user with no company' do
      before do
        @user = create(:user, :with_no_company, :with_confirmed_email)
      end

      context 'with valid credentials' do
        before do
          post :create, params: { session: { email: @user.email, password: @user.password } }
        end

        it 'sets the user in session' do
          expect(controller.current_user).to eq @user
        end

        it 'logs user' do
          expect(controller).to be_logged_in
          expect(controller).to_not be_logged_out
        end
        
        it { should redirect_to company_signup_welcome_path }
      end
    end

    context "given a verified user with a company" do
      before do
        @user = create(:user, :with_company, :with_confirmed_email)
      end

      context 'with valid credentials' do
        before do
          post :create, params: { session: { email: @user.email, password: @user.password } }
        end

        it 'logs user' do
          expect(controller.current_user).to eq @user
          expect(controller).to be_logged_in
          expect(controller).to_not be_logged_out
        end
        
        it { should redirect_to root_path }
      end
    end
  end

  describe 'delete #destroy' do
    before do
      login
      delete :destroy
    end

    it { should redirect_to root_url }
    it { expect(controller).to_not be_logged_in }
    it { expect(controller).to be_logged_out }
    it { expect(controller.current_user).to be_nil }
  end
end
