describe Address do
  it { should belong_to :country }
  it { should validate_presence_of :street }
  it { should validate_presence_of :city }
  it { should validate_presence_of :region }
  it { should validate_presence_of :postal_code }
  it { should validate_presence_of :country }
end
