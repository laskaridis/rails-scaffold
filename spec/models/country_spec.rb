
describe Country do
  subject { create :country }

  it { is_expected.to validate_presence_of :code }
  it { is_expected.to validate_uniqueness_of :code }

  describe '#name' do
    subject { build :country }

    it 'returns the translated country name' do
      expected_name = I18n.t("countries.#{subject.code}")

      expect(subject.name).to eq expected_name
    end
  end
end
