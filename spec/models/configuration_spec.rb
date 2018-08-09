describe Configuration do

  it "should default mailer sender to `noreply@company.com`" do
    expect(subject.mailer_sender).to eq "noreply@company.com"
  end
end
