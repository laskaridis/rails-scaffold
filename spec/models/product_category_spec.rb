describe ProductCategory do
  it { should validate_presence_of(:name) }

  context "given an existing product category" do
    before { create(:fruits) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
