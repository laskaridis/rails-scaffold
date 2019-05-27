describe Notification do
  it { should validate_presence_of :subject }
  it { should validate_length_of(:subject).is_at_most(100) }
  it { should validate_presence_of :body }
  it { should validate_presence_of :type }
  it { should validate_length_of(:type).is_at_most(50) }
  it { should belong_to :user }

  context "factories" do
    it "should build a valid notification" do
      expect(build(:notification)).to be_valid
    end
  end
end
