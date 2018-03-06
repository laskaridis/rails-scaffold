describe Contact do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }

  context "given an existing contact" do
    before { create :contact }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  context "factories" do

    it "should build a valid contact" do
      expect(build(:contact)).to be_valid
    end
  end
end
