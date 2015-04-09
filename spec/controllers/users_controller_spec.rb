describe UsersController do

  describe 'GET #new' do

    context 'when user is not logged in' do
      before { get :new }

      it { should respond_with :success }
      it { should render_template :new }
      it { should_not set_flash }
    end

    context 'when user is logged in' do
      before do
        login
        get :new
      end

      it { should redirect_to storefront_url }
      it { should_not set_flash }
    end
  end

  describe 'POST #create' do

    context 'when user is not logged in' do
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

    context 'when user is logged in' do
      before do
        login
        post :create, user: {}
      end

      it { should redirect_to storefront_url }
    end
  end

  describe 'GET #verify' do

    context 'when no user cannot be found' do
      before { get :verify, token: 'invalid' }

      it { should redirect_to storefront_url }
    end

    context 'when email verification token has not expired' do
      before do
        @user = create(:user)
        get :verify, token: @user.email_confirmation_token
      end

      it 'verifies user email' do
        expect(@user).to be_email_confirmed
      end
      it { should redirect_to storefront_url }
    end

    context 'when email verification token has expired' do
      before do
        @user = create(:user)
        get :verify, token: @user.email_confirmation_token
      end

      it 'resets the email confirmation token' do

      end
      it { should set_flash with(warning: t('errors.verify_email.expired')) }
      it { should redirect_to storefront_url }
    end
  end
end
