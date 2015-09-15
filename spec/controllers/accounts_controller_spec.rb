
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
        @user = create(:user, password: "password")
        login_as @user
      end

      context 'with valid attribites' do
        before do
          attributes = {
              change_password_form: {
                  old_password: "password",
                  password: "new_password",
                  password_confirmation: "new_password"
              }
          }
          put :change_password, attributes
        end

        it { should redirect_to edit_account_path }
        it { expect(flash[:success]).to eq I18n.t("successes.password_changed") }

        it "should change password of logged user" do
          expect(@user.reload.authenticated?("new_password")).to eq true
          expect(@user.reload.authenticated?("password")).to eq false
        end
      end

      context 'with invalid attribites' do
        before do
          attributes = {
              change_password_form: {
                  old_password: "password",
                  password: "new_password",
                  password_confirmation: "invalid"
              }
          }
          put :change_password, attributes
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
end
