describe Role do

  it { should validate_presence_of(:name) }
  it { should have_db_index(:name).unique }
  it { should validate_length_of(:name).is_at_most(255) }
  it { should have_and_belong_to_many(:permissions) }

  context "given an existing role" do
    before do
      create :role
    end

    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
