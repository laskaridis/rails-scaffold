
describe ChangePasswordForm do

  let(:user) { create(:user, password: "password") }
  subject { ChangePasswordForm.new user }

  it { is_expected.to validate_presence_of :old_password }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_presence_of :password_confirmation }
  it { is_expected.to validate_confirmation_of :password }

  context 'when old password is invalid' do
    before do
      subject.old_password = 'ivnalid'
      expect(subject).to_not be_valid
    end

    it 'should not be valid' do
      expect(subject.errors[:old_password]).to include I18n.t('errors.old_password_incorrect')
    end
  end

  describe '#perform' do

    it 'should update password when parameters are valid' do 
      result = subject.perform(
        old_password: "password",
        password: "new_password",
        password_confirmation: "new_password"
      )

      expect(result).to eq true
      expect(user.authenticated?("password")).to eq false
      expect(user.authenticated?("new_password")).to eq true
    end

    it 'should not update password when parameters are invalid' do
      result = subject.perform(
        old_password: "password",
        password: "new_password",
        password_confirmation: "invalid"
      )

      expect(result).to eq false
      expect(user.authenticated?("password")).to eq true
      expect(user.authenticated?("new_password")).to eq false
    end
  end
end
