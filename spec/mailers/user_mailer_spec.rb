
describe UserMailer do

  describe "#change_password" do
    before do
      @user = create(:user, :pending_password_change)
      @email = UserMailer.change_password(@user)
    end

    it "is from DO NOT REPLY" do
      expect(Configuration.configuration.mailer_sender).to eq @email.from[0]
    end

    it "is sent to user" do
      expect(@email.to.first).to eq @user.email
    end

    it "sets its subject" do
      expect(@email.subject).to eq I18n.t('mailer.change_password.subject')
    end

    it "has html and plain text parts" do
      expect(@email.body.parts).to be_present
      expect(@email.text_part).to be_present
      expect(@email.html_part).to be_present
    end

    it "contains a link to change the password" do
      link = edit_password_url(id: @user.id, token: @user.password_change_token)
      expect(@email.text_part.body).to include(link)
      expect(@email.html_part.body).to include(link)
    end
  end

  describe "#confirm_email" do
    before do
      @user = create(:user, :with_confirmed_email)
      @email = UserMailer.confirm_email(@user)
    end

    it "is from DO NOT REPLY" do
      expect(Configuration.configuration.mailer_sender).to eq @email.from[0]
    end

    it "is sent to user" do
      expect(@email.to.first).to eq @user.email
    end

    it "sets its subject" do
      expect(@email.subject).to eq I18n.t('mailer.verify_email.subject')
    end

    it "has html and plain text parts" do
      expect(@email.body.parts).to be_present
      expect(@email.text_part).to be_present
      expect(@email.html_part).to be_present
    end

    it "contains a link to confirm email" do
      link = verify_email_url(token: @user.email_confirmation_token)
      expect(@email.text_part.body).to include(link)
      expect(@email.html_part.body).to include(link)
    end
  end
end
