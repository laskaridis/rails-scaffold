describe Permission do
  it { should validate_presence_of(:name) }
  it { should have_db_index(:name).unique(true) }
  it { should validate_length_of(:name).is_at_most(255) }
  it { should validate_presence_of(:action) }
  it { should validate_length_of(:action).is_at_most(255) }
  it { should validate_presence_of(:resource) }
  it { should validate_length_of(:resource).is_at_most(255) }
  it { should have_db_index([:action, :resource]).unique(true) }

  context "given an existing permission" do
    before do
      create :permission
    end

    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_uniqueness_of(:action).scoped_to(:resource).case_insensitive }
  end
end
