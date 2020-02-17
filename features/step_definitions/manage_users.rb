
Given("the following registered users:") do |table|
  @users = table.raw.filter do |row|
    create(:user, :with_confirmed_email, email: row[0])
  end
end

Given("I am an administrator") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I vist the users administration page") do
  @view = ManageUsersView.new
end

Then("I should see all the registered users") do
  @view.assert_shows_user
end
