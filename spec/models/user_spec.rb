describe User do
  it { should have_db_index(:email) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password).on(:create) }
  it { should allow_value("foo@example.co.uk").for(:email) }
  it { should allow_value("foo@example.com").for(:email) }
  it { should allow_value("foo+bar@example.com").for(:email) }
  it { should_not allow_value("foo@").for(:email) }
  it { should_not allow_value("foo").for(:email) }
  it { should_not allow_value("example.com").for(:email) }
  it { should validate_inclusion_of(:gender).in_array(%w(Male Female)).allow_blank }
  it { should belong_to(:country).optional }
  it { should belong_to(:currency).optional }
  it { should belong_to(:language).optional }
  it { should have_many(:notifications) }

  describe "#find_or_create_from_omniauth" do
    before do
      create(:currency, code: "EUR", symbol: "EUR")
      create(:language, code: "en")
    end

    context "given an oauth hash" do
      let(:user) { build(:user) }
      let(:hash) do
        OmniAuth::AuthHash.new({
          provider: "google_oauth2",
          uid: "1234567890",
          info: {
            email: user.email
          },
          credentials: {
            token: "abcdef123456",
            refresh_token: "123456abcdef",
            expires_at: Time.zone.now
          }
        })
      end

      context "when a user by that email exists" do
        before { user.save! }

        it "should return existing user" do
          result = User.find_or_create_from_omniauth(hash)
          expect(result).to be_persisted
          expect(result.email).to eq user.email
          expect(result.country).to eq user.country
          expect(result.currency).to eq user.currency
          expect(result.language).to eq user.language
          expect(result.provider).to be_nil
        end
      end

      context "when no user by that email exists" do

        it "should create and return a new user" do
          result = User.find_or_create_from_omniauth(hash)
          expect(result).to be_persisted
          expect(result.email).to eq user.email
          expect(result.country).to be_nil
          expect(result.currency).to eq Currency.default
          expect(result.language).to eq Language.default
          expect(result.provider).to eq "google_oauth2"
        end
      end
    end
  end

  describe "user factory" do

    it "should build a valid user" do
      expect(build(:user)).to be_valid
    end

    it "should build a valid user with just an overridden password" do
      expect(build(:user, password: "test123")).to be_valid
    end

    it "should build a valid user with confirmed email" do
      user = build(:user, :with_confirmed_email)
      expect(user).to be_valid
      expect(user).to be_confirmed
    end

    it "should build a valid user with unconfirmed email" do
      user = build(:user, :with_unconfirmed_email)
      expect(user).to be_valid
      expect(user).to_not be_confirmed
    end
  end
end
