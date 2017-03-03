
describe DeleteAccountForm do

  let(:user) { create(:user) }
  subject { DeleteAccountForm.new(user) }

  it { should validate_presence_of :email }

  it "should validate that email matches user account email" do
    subject.email = "invalid@localhost"
    expect(subject).to_not be_valid
    expect(subject.errors[:email]).to include I18n.t("errors.delete_account")
  end

  describe "#perform" do

    context "when parameters are valid" do
      before do
        subject.perform(email: user.email)
      end

      it "should delete user" do
        expect(User.find_by_email(user.email)).to be_nil
      end
    end

    context "when form is invalid" do
      before do
        subject.perform
      end
      
      it "should not delete user" do
        expect(User.find_by_email(user.email)).to eq user
      end
    end
  end
end
