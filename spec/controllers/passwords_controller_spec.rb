
describe PasswordsController do

  describe "#new" do
    before { get :new }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:new) }
  end

  describe "#create" do

    context "given and email that corresponds to a registered user" do
      before do
        @user = create(:user)
        expect(@user.password_change_token).to be_nil
        expect(@user.password_change_requested_at).to be_nil
        post :create, password: {email: @user.email}
        @user.reload
      end

      it "generates password change token" do
        expect(@user.password_change_token).to_not be_nil
        expect(@user.password_change_requested_at).to_not be_nil
        expect(@user.password_changed_at).to be_nil
      end

      it "sends the password reset email" do
        email = ActionMailer::Base.deliveries.last
        expect(email.subject).to match /Change your password/
      end

      it { expect(flash[:success]).to include pending_confirmation_message }
      it { should redirect_to root_url }

      def pending_confirmation_message
        I18n.t("successes.reset_email").gsub(/:email/, @user.email)
      end
    end

    context "given and email that does not correspond to a registered user" do
      before { post :create, password: {email: "invalid@domain.com"} }

      it { expect(flash[:error]).to include email_not_found_message }
      it { expect(response).to render_template(:new) }

      def email_not_found_message
        I18n.t("errors.reset_email_not_found")
      end
    end
  end

  describe '#edit' do

    context 'given a non expired password confirmation token' do
      before do
        user = create(:user, :pending_password_change)
        get :edit, id: user.id, token: user.password_change_token
      end

      it { should render_template :edit }
      it { should_not set_flash }
    end

    context 'given an expired password confirmation token' do
      before do
        user = create(:user, :with_expired_password_change_token)
        get :edit, id: user.id, token: user.password_change_token
      end

      it { should render_template :new }
      it { should set_flash }
    end

    context 'given a non existing password confirmation token' do
      before do
        user = create(:user)
        get :edit, id: user.id, token: 'invalid'
      end

      it { should redirect_to root_url }
      it { should_not set_flash }
    end
  end

  describe '#update' do

    context 'given a non expired password confirmation token' do
      before do
        @user = create(:user, :pending_password_change)
        put :update, id: @user.id,
          token: @user.password_change_token,
          password: { password: "newpassword" }
        @user.reload
      end

      it "logs user" do
        expect(controller).to be_logged_in
      end
      it "changes user password" do
        expect(@user.authenticated? "newpassword").to eq true
      end
      it "sets password_changed_at" do
        expect(@user.password_changed_at).to_not be_nil
      end
      it { should redirect_to root_url }
      it { should set_flash }
    end

    context 'given a non existing password confirmation token' do
      before do
        user = create(:user)
        put :update, id: user.id,
          token: 'invalid',
          password: { password: 'newpassword' }
      end

      it { should redirect_to root_url }
      it { should_not set_flash }
    end
  end
end
