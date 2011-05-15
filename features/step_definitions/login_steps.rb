Given /^I am an admin user$/ do
  @user = User.create!
end

When /^I fill in username with "([^"]*)"$/ do |username|
  visit login_path   
  fill_in "user_email", :with => username 
end

When /^I fill in password with "([^"]*)"$/ do |password|
  pending # express the regexp above with the code you wish you had
end

When /^I press the save button$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should be taken to the home page$/ do
   click_button "Save"
end
