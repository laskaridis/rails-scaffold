describe User do
  it { should have_db_index(:email) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password).on(:create) }
  it { should allow_value("foo@example.co.uk").for(:email) }
  it { should allow_value("foo@example.com").for(:email) }
  it { should allow_value("foo+bar@example.com").for(:email) }
  it { should_not allow_value("foo@").for(:email) }
  it { should_not allow_value("foo@example..com").for(:email) }
  it { should_not allow_value("foo@.example.com").for(:email) }
  it { should_not allow_value("foo").for(:email) }
  it { should_not allow_value("example.com").for(:email) }
  it { should_not allow_value("foo;@example.com").for(:email) }
  it { should validate_inclusion_of(:gender).in_array(%w(Male Female)).allow_blank }
  it { should belong_to :country }
  it { should belong_to :currency }
  it { should belong_to :language }

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
