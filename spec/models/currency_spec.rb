
describe Currency do
  subject { create :eur }

  it { is_expected.to validate_presence_of :code }
  it { is_expected.to validate_uniqueness_of :code }
  it { is_expected.to validate_presence_of :symbol }

  describe '#name' do

    it 'returns the translated currency name' do
      expected_name = I18n.t("currencies.#{subject.code}")

      expect(subject.name).to eq expected_name
    end
  end
end
