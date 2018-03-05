describe ProductFamily do
  it { should belong_to :product_category }
  it { should validate_presence_of :product_category }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).case_insensitive }
end
