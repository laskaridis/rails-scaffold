
describe Message do

  it { should belong_to(:sender).class_name("User") }
  it { should belong_to(:recipient).class_name("User") }
  it { should validate_presence_of(:sender) }
  it { should validate_presence_of(:recipient) }
  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:message) }

  describe "message factory" do

    it "should build a valid message" do
      expect(build(:message)).to be_valid
    end
  end
end
