describe ProductFamily do
  it { should belong_to :product_category }
  it { should have_many(:product_varieties).inverse_of(:product_family) }
  it { should validate_presence_of :product_category }
  it { should validate_presence_of :name }

  context "given an existing product family" do
    before { create :product_family }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  context "factories" do
    subject { build :product_family }
    it { should be_valid }
  end
end
