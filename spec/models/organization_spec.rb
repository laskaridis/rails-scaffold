describe Organization do
  it { should belong_to :address }
  it { should belong_to :user }
  it { should belong_to :contact }
  it { should validate_presence_of :name }
  it { should validate_presence_of :address }
  it { should validate_presence_of :contact }
  it { should validate_presence_of :vat_number }
  it { should validate_presence_of :tax_office }
  it { should accept_nested_attributes_for :address }
  it { should accept_nested_attributes_for :contact }
  it { should validate_inclusion_of(:size).in_array(%w(1 2-9 10-99 100-299 300+)).allow_blank }

  context "factories" do

    it "should build a valid organization" do
      expect(build(:organization)).to be_valid
    end
  end
end
