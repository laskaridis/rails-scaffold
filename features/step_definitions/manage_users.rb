
Given("the following registered users:") do |table|
  pending # TODO
end

Given("I am an administrator") do
  pending # TODO
end

When("I vist the users administration page") do
  @view = ManageUsersView.new
end

Then("I should see all the registered users") do
  @view.assert_shows_user
end
