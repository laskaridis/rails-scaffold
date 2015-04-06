
describe UserMailer do

  describe "#change_password" do

    it "is from DO NOT REPLY" do
      user = create(:user, :pending_password_change)
      email = UserMailer.change_password(user)
      expect(Configuration.configuration.mailer_sender).to eq email.from[0]
    end

    it "is sent to user" do
      user = create(:user, :pending_password_change)
      email = UserMailer.change_password(user)
      expect(email.to.first).to eq user.email
    end

    it "sets its subject"

    it "has html and plain text parts" do
      user = create(:user, :pending_password_change)
      email = UserMailer.change_password(user)
      expect(email.body.parts).to be_present
      expect(email.text_part).to be_present
      expect(email.html_part).to be_present
    end

    it "contains a link to change the password"
  end

  describe "#confirm_email" do

    it "is from DO NOT REPLY" do
      user = create(:user, :with_confirmed_email)
      email = UserMailer.confirm_email(user)
      expect(Configuration.configuration.mailer_sender).to eq email.from[0]
    end

    it "is sent to user" do
      user = create(:user, :with_confirmed_email)
      email = UserMailer.confirm_email(user)
      expect(email.to.first).to eq user.email
    end

    it "sets its subject"

    it "has html and plain text parts" do
      user = create(:user, :with_confirmed_email)
      email = UserMailer.confirm_email(user)
      expect(email.body.parts).to be_present
      expect(email.text_part).to be_present
      expect(email.html_part).to be_present
    end

    it "contains a link to confirm email"
  end
end
