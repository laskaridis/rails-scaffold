
describe User do

  describe "user factory" do

    it "should build a valid user" do
      expect(build(:user)).to be_valid
    end

    it "should build a valid user with just an overridden password" do
      expect(build(:user, password: "test", password_confirmation: "test")).to be_valid
    end

    it "should build a valid user with confirmed email" do
      user = build(:user, :with_confirmed_email)
      expect(user).to be_valid
      expect(user.email_confirmation_token).to_not be_nil
      expect(user.email_confirmation_requested_at).to_not be_nil
      expect(user.email_confirmed_at).to_not be_nil
    end

    it "should build a vaild user with password changed" do
      user = build(:user, :with_changed_password)
      expect(user).to be_valid
      expect(user.password_change_token).to_not be_nil
      expect(user.password_change_requested_at).to_not be_nil
      expect(user.password_changed_at).to_not be_nil
    end
  end
end
