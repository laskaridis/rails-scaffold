describe ProductVariety do
  it { should belong_to :product_family }
  it { should validate_presence_of :product_family }
  it { should validate_presence_of :name }

  context "given an existing product variety" do
    before { create(:fuji) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
