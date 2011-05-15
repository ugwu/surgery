Given /^that I am logged in as an admin user$/ do
 @logged_in_user = User.create! 
end

When /^I add an "([^\"]*)" user$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
