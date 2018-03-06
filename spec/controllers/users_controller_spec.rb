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

      it { should redirect_to root_url }
      it { should_not set_flash }
    end
  end

  describe 'POST #create' do

    context 'when user is not logged in' do
      context 'with valid attributes' do
        before do
          user_attributes = FactoryBot.attributes_for(:user)
          post :create, params: { user: user_attributes }
        end

        it 'redirects to storefront url' do
          expect(response).to redirect_to login_url
        end

        it 'should not log user' do
          expect(controller).to be_logged_out
        end

        it 'should not set the current user' do
          expect(controller.current_user).to be_nil
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
        post :create, params: { user: {} }
      end

      it { should redirect_to root_url }
    end
  end

  describe 'GET #verify' do

    context 'when no user cannot be found' do

      it 'raises an error' do
        expect { get :verify, params: { token: 'invalid' }}.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when email verification token has not expired' do
      before do
        @user = create(:user)
        expect(@user).to_not be_email_confirmation_expired
        expect(@user).to_not be_email_confirmed
        get :verify, params: { token: @user.email_confirmation_token }
      end

      it 'verifies user email' do
        expect(@user.reload).to be_email_confirmed
      end
      it { should redirect_to login_url }
      it { expect(flash[:success]).to eq I18n.t('successes.verify_email') }
    end

    context 'when email verification token has expired' do
      before do
        @user = create_user_with_expired_token
        @old_token = @user.email_confirmation_token
        get :verify, params: { token: @user.email_confirmation_token }
      end

      def create_user_with_expired_token
        user = create(:user)
        config = Configuration.configuration
        expiration_period = config.email_confirmation_expiration
        user.email_confirmation_requested_at = (expiration_period + 1).hours.ago
        user.save!
        expect(user).to be_email_confirmation_expired
        user
      end

      it 'resets the email confirmation token' do
        expect(@old_token).to_not eq @user.reload.email_confirmation_token
      end
      it { expect(flash[:warning]).to eq I18n.t('errors.verify_email.expired') }
      it { should redirect_to login_url }
    end
  end

  describe "PUT #update_profile" do
    before { @user = login }

    context "when parameters are valid" do
      before do
        @new_params = {gender: 'Male' }
        put :update_profile, params: { user: @new_params }
      end

      it 'updates user' do
        user = User.find(@user.id)
        expect(user.gender).to eq @new_params[:gender]
        expect(user.country).to eq @user.country
        expect(user.currency).to eq @user.currency
        expect(user.language).to eq @user.language
        expect(user.time_zone).to eq @user.time_zone
        expect(user.receive_email_notifications).to eq @user.receive_email_notifications
      end

      it { should redirect_to user_profile_path }
      it { expect(flash[:success]).to eq I18n.t('successes.profile_updated') }

    end

    context 'when parameters are invalid' do
      before do
        put :update_profile, params: { user: { } }
      end

      it 'should not update user' do
        user = User.find(@user.id)
        expect(user.gender).to eq @user.gender
      end
    end
  end

  describe "PUT #update_settings" do
    before { @user = login }

    context "when parameters are valid" do
      before do
        @new_params = {
          country_id: create(:country).id,
          currency_id: create(:eur).id,
          language_id: create(:english).id,
          time_zone: 'Athens',
        }
        put :update_settings, params: { user: @new_params }
      end

      it 'updates user' do
        user = User.find(@user.id)
        expect(user.gender).to eq @user.gender
        expect(user.country.id).to eq @new_params[:country_id]
        expect(user.currency.id).to eq @new_params[:currency_id]
        expect(user.language.id).to eq @new_params[:language_id]
        expect(user.time_zone).to eq @new_params[:time_zone]
        expect(user.receive_email_notifications).to eq @user.receive_email_notifications
      end

      it { should redirect_to user_settings_path }
      it { expect(flash[:success]).to eq I18n.t('successes.profile_updated') }
    end

    context 'when parameters are invalid' do
      before do
        put :update_settings, params: { user: { } }
      end

      it 'should not update user' do
        user = User.find(@user.id)
        expect(user.country).to eq @user.country
        expect(user.currency).to eq @user.currency
        expect(user.language).to eq @user.language
        expect(user.time_zone).to eq @user.time_zone
      end
    end
  end

  describe "PUT #update_preferences" do
    before { @user = login }

    context "when parameters are valid" do
      before do
        @new_params = {
          receive_email_notifications: !@user.receive_email_notifications
        }
        put :update_preferences, params: { user: @new_params }
      end

      it 'updates user' do
        user = User.find(@user.id)
        expect(user.gender).to eq @user.gender
        expect(user.country).to eq @user.country
        expect(user.currency).to eq @user.currency
        expect(user.language).to eq @user.language
        expect(user.time_zone).to eq @user.time_zone
        expect(user.receive_email_notifications).to eq @new_params[:receive_email_notifications]
      end

      it { should redirect_to user_preferences_path }
      it { expect(flash[:success]).to eq I18n.t('successes.profile_updated') }
    end

    context 'when parameters are invalid' do
      before do
        put :update_preferences, params: { user: { } }
      end

      it 'should not update user' do
        user = User.find(@user.id)
        expect(user.receive_email_notifications).to eq @user.receive_email_notifications
      end
    end
  end
end
