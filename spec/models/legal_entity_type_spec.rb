describe LegalEntityType do
  it { should validate_presence_of :name }

  context "given an existing legal entity type" do
    before { create :legal_entity_type }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  context "factories" do
    subject { build :legal_entity_type }
    it { should be_valid }
  end
end
