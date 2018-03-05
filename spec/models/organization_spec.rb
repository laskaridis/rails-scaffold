describe Organization do
  it { should belong_to :address }
  it { should validate_presence_of :name }
  it { should validate_presence_of :address }
  it { should validate_presence_of :vat_number }
  it { should validate_presence_of :contact_first_name }
  it { should validate_presence_of :contact_last_name }
  it { should validate_presence_of :contact_email }

  context "factories" do

    it "should build a valid organization" do
      expect(build(:organization)).to be_valid
    end
  end
end
