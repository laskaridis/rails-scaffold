
describe AccountsController do

  describe 'GET #edit' do

    context 'when the user is logged in' do
      before do
        login
        get :edit
      end

      it { should respond_with :success }
      it { should render_template :edit }
      it { should_not set_flash }
    end

    context 'when the user is not logged in' do
      before { get :edit }

      it { should redirect_to login_url }
      it { should_not set_flash }
    end
  end

  describe 'PUT #change_password' do

    context 'when the user is logged in' do
      before do
        @user = login_as(create(:user, password: "password"))
      end

      context 'with valid attribites' do
        before do
          put :change_password, { change_password_form: {
            old_password: "password",
            password: "new_password",
            password_confirmation: "new_password" }
          }
        end

        it { should redirect_to user_account_path }
        it { expect(flash[:success]).to eq I18n.t("successes.password_changed") }

        it "should change password of logged user" do
          expect(@user.reload.authenticated?("new_password")).to eq true
          expect(@user.reload.authenticated?("password")).to eq false
        end
      end

      context 'with invalid attribites' do
        before do
          put :change_password, { change_password_form: {
            old_password: "password",
            password: "new_password",
            password_confirmation: "invalid" }
          }
        end

        it { should render_template :edit }

        it "should not change password of logged user" do
          expect(@user.reload.authenticated?("new_password")).to eq false
          expect(@user.reload.authenticated?("password")).to eq true
        end
      end
    end

    context 'when the user is not logged in' do
      before { put :change_password }

      it { should redirect_to login_url }
      it { should_not set_flash }
    end
  end

  describe "DELETE #destroy" do

    context "given a logged in user" do
      before do
        @user = login
      end

      context "and valid parameters" do
        before do
          delete :destroy, delete_account_form: { email: @user.email }
        end

        it { should redirect_to root_path }
        it { should be_logged_out }

        it "should delete user" do
          expect(User.find_by_email(@user.email)).to be_nil
        end
      end

      context "and invalid parameters" do
        before do
          delete :destroy, delete_account_form: { email: "invalid@localhost" }
        end

        it { should render_template :edit }
        it { should be_logged_in }

        it "should not delete user" do
          expect(User.find_by_email(@user.email)).to be_present
        end
      end
    end

    context "given a logged out user" do
      before do
        delete :destroy
      end

      it { should redirect_to login_url }
    end
  end
end
