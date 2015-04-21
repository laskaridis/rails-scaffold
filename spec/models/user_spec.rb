
describe User do

  it { is_expected.to have_db_index(:email) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password).on(:create) }
  it { is_expected.to allow_value("foo@example.co.uk").for(:email) }
  it { is_expected.to allow_value("foo@example.com").for(:email) }
  it { is_expected.to allow_value("foo+bar@example.com").for(:email) }
  it { is_expected.not_to allow_value("foo@").for(:email) }
  it { is_expected.not_to allow_value("foo@example..com").for(:email) }
  it { is_expected.not_to allow_value("foo@.example.com").for(:email) }
  it { is_expected.not_to allow_value("foo").for(:email) }
  it { is_expected.not_to allow_value("example.com").for(:email) }
  it { is_expected.not_to allow_value("foo;@example.com").for(:email) }

  describe "#email" do
    it "stores email in down case and removes whitespace" do
      user = create(:user, email: "Jo hn.Do e @exa mp le.c om")

      expect(user.email).to eq "john.doe@example.com"
    end

    subject { create(:user) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe '#reset_email_confirmation_token' do

    it 'does not change email_confirmation_token if confirmed' do
      user = create(:user, :with_confirmed_email)
      token_before = user.email_confirmation_token
      user.reset_email_confirmation_token
      expect(user.email_confirmation_token).to eq token_before
    end

    it 'does not change email_confirmation_requested_at if confirmed' do
      user = create(:user, :with_confirmed_email)
      date_before = user.email_confirmation_requested_at
      user.reset_email_confirmation_token
      expect(user.email_confirmation_requested_at).to eq date_before
    end

    it 'changes email_confirmation_token if not confirmed' do
      user = create(:user)
      token_before = user.email_confirmation_token
      user.reset_email_confirmation_token
      expect(user.email_confirmation_token).to_not eq token_before
    end

    it 'changes email_confirmation_requested_at if not confirmed' do
      user = create(:user)
      date_before = user.email_confirmation_requested_at
      user.reset_email_confirmation_token
      expect(user.email_confirmation_requested_at).to_not eq date_before
    end

    it 'sends an email to confirm email' do
      user = create(:user)
      mailer = double('Mailer')
      expect(mailer).to receive(:deliver_later).
        with(queue: 'confirm_email_email')
      expect(UserMailer).to receive(:confirm_email).
        with(user).and_return(mailer)
      user.reset_email_confirmation_token
    end
  end

  describe '#generate_password_change_token' do

    it 'changes password_change_token' do
      user = create(:user)
      token_before = user.password_change_token
      user.generate_password_change_token
      expect(user.password_change_token).to_not eq token_before
    end

    it 'changes password_change_requested_at' do
      user = create(:user)
      date_before = user.password_change_requested_at
      user.generate_password_change_token
      expect(user.password_change_requested_at).to_not eq date_before
    end

    it 'clears password_changed_at' do
      user = create(:user, :with_changed_password)
      user.generate_password_change_token
      expect(user.password_changed_at).to be_nil
    end

    it 'sends an email to change password' do
      user = create(:user)
      mailer = double('Mailer')
      expect(mailer).to receive(:deliver_later).
        with(queue: 'change_password_email')
      expect(UserMailer).to receive(:change_password).with(user).and_return(mailer)
      user.generate_password_change_token
    end
  end

  describe '#email_confirmed?' do

    it 'is true when email_confirmed_at is set' do
      subject.email_confirmed_at = DateTime.now
      expect(subject).to be_email_confirmed
    end

    it 'is false when mail_confirmed_at is not set' do
      subject.email_confirmed_at = nil
      expect(subject).to_not be_email_confirmed
    end
  end

  describe '#email_confirmation_expired?' do
    subject { create(:user) }

    def stub_email_confirmation_expiration_to(hours)
      Configuration.configure do |config|
        config.email_confirmation_expiration = hours
      end
    end

    it 'is true when email_confirmation_requested_at has expired' do
      stub_email_confirmation_expiration_to 1
      subject.email_confirmation_requested_at = 2.hours.ago
      config = Configuration.configuration
      expires_at =
        subject.email_confirmation_requested_at +
        config.email_confirmation_expiration.hours
      expect(DateTime.now > expires_at).to eq true
      expect(subject).to be_email_confirmation_expired
    end

    it 'is false when email_confirmation_requested_at has not expired' do
      stub_email_confirmation_expiration_to 2
      subject.email_confirmation_requested_at = 1.hour.ago
      config = Configuration.configuration
      expires_at =
        subject.email_confirmation_requested_at +
        config.email_confirmation_expiration.hours
      expect(DateTime.now < expires_at).to eq true
      expect(subject).to_not be_email_confirmation_expired
    end
  end

  describe '#password_change_expired?' do
    subject { create(:user) }

    def stub_password_change_expiration_to(hours)
      Configuration.configure do |config|
        config.password_change_expiration = hours
      end
    end

    it 'is true when password change token has expired' do
      stub_password_change_expiration_to 1
      subject.password_change_requested_at = 2.hours.ago
      config = Configuration.configuration
      expires_at =
        subject.password_change_requested_at +
        config.password_change_expiration.hours
      expect(DateTime.now > expires_at).to eq true
      expect(subject).to be_password_change_expired
    end

    it 'is false when password change token has not expired' do
      stub_password_change_expiration_to 2
      subject.password_change_requested_at = 1.hour.ago
      config = Configuration.configuration
      expires_at =
        subject.password_change_requested_at +
        config.password_change_expiration.hours
      expect(DateTime.now < expires_at).to eq true
      expect(subject).to_not be_password_change_expired
    end
  end

  describe '#confirm_email' do
    subject { create(:user) }

    it 'is not verified when email confirmation token is expired' do
      allow(subject).to receive(:email_confirmation_expired?).and_return(true)
      expect(subject.email_confirmed_at).to be_nil
      expect(subject.confirm_email).to eq false
      expect(subject.email_confirmed_at).to be_nil
    end

    it 'is verified when email confirmation token is not expired' do
      allow(subject).to receive(:email_confirmation_expired?).and_return(false)
      expect(subject.email_confirmed_at).to be_nil
      expect(subject.confirm_email).to eq true
      expect(subject.email_confirmed_at).to be_present
    end
  end

  describe '#password_change_pending?' do

    it 'returns true if password change has been requested but not changed' do
      subject.password_change_requested_at = DateTime.now
      subject.password_changed_at = nil
      expect(subject).to be_password_change_pending
    end

    it 'returns false if password change has been requested and changed' do
      subject.password_change_requested_at = DateTime.now
      subject.password_changed_at = DateTime.now
      expect(subject).to_not be_password_change_pending
    end

    it 'returns false if password change has not been requested' do
      subject.password_change_requested_at = nil
      expect(subject).to_not be_password_change_pending
    end
  end

  describe ".authenticate" do
    it "is authenticated with correct email and password" do
      user = create(:user)
      password = user.password

      expect(User.authenticate(user.email, password)).to eq(user)
    end

    it "is authenticated with correct uppercased email and correct password" do
      user = create(:user)
      password = user.password

      expect(User.authenticate(user.email.upcase, password)).to eq(user)
    end

    it "is not authenticated with incorrect credentials" do
      user = create(:user)

      expect(User.authenticate(user.email, "bad_password")).to be_nil
    end
  end

  describe "after_create_ callbacks" do
    describe "#generate_email_confirmation_token" do
      it "does not generate same email confirmation token for users with same password" do
        allow(Time).to receive(:now).and_return(Time.now)
        password = "secret"
        first_user = create(:user, password: password)
        second_user = create(:user, password: password)

        expect(second_user.email_confirmation_token).not_to eq first_user.email_confirmation_token
      end
    end
  end


  describe "email address normalization" do
    it "downcases the address and strips spaces" do
      email = "Jo hn.Do e @exa mp le.c om"

      expect(User.normalize_email(email)).to eq "john.doe@example.com"
    end
  end

  describe '#change_password' do
    subject { create(:user, :pending_password_change, password: 'password') }

    context 'when password change token has been expired' do
      before { allow(subject).to receive(:password_change_expired?).and_return(true) }

      it 'returns false' do
        expect(subject.change_password('newpassword')).to eq false
      end

      it 'does not change password' do
        expect(subject.authenticated?('newpassword')).to eq false
        expect(subject.change_password('newpassword')).to eq false
        expect(subject.authenticated?('newpassword')).to eq false
        expect(subject.authenticated?('password')).to eq true
        expect(subject.password_changed_at).to be_nil
      end

      it 'generates new password change token' do
        old_token = subject.password_change_token
        requested_at = subject.password_change_requested_at
        expect(subject.change_password('newpassword')).to eq false
        expect(subject.password_change_token).to_not eq old_token
        expect(subject.password_change_requested_at).to_not eq requested_at
      end
    end

    context 'when password change token has not been expired' do
      before { expect(subject).to receive(:password_change_expired?).and_return(false) }

      it 'returns true' do
        expect(subject.change_password('newpassword')).to eq true
      end

      it 'changes password' do
        expect(subject.authenticated?('newpassword')).to eq false
        expect(subject.change_password('newpassword')).to eq true
        expect(subject.authenticated?('newpassword')).to eq true
        expect(subject.password_changed_at).to_not be_nil
      end

      it 'does not generate a new password change token' do
        old_token = subject.password_change_token
        requested_at = subject.password_change_requested_at
        expect(subject.change_password('newpassword')).to eq true
        expect(subject.password_change_token).to eq old_token
        expect(subject.password_change_requested_at).to eq requested_at
      end
    end
  end

  describe "the password setter on a User" do
    it "sets password to the plain-text password" do
      password = "password"
      subject.send(:password=, password)

      expect(subject.password).to eq password
    end

    it "also sets encrypted_password" do
      password = "password"
      subject.send(:password=, password)

      expect(subject.encrypted_password).to_not be_nil
    end
  end
end
