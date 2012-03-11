Given /^I am logged out$/ do
  visit logout_url
end

When /^I log in$/ do
  visit root_url
  click_link "Login"
end

Then /^I should be logged in$/ do
  page.should_not have_link "Login"
  page.should have_link "Logout"
end
