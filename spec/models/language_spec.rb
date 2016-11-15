
describe Language do
  
  it { is_expected.to validate_presence_of :code }

  context "given an existing instance" do
    before { create(:language) }

    it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
  end

  describe '#name' do
    subject { build :english }

    it 'returns the translated language name' do
      expected_name = I18n.t("languages.#{subject.code}")

      expect(subject.name).to eq expected_name
    end
  end
end
