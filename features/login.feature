Feature: Login feature

As a user
I want to login in to my surgery application
So that I can use the app privately to me


@wip
@login
Scenario: An admin user logs in with the correct user name and password
Given I am an admin user
And I am on the login_page
When I fill in username with "admin@surgery.com"
And I fill in password with "ABCD5678"
And I press the save button
Then I should be taken to the home page


@wip
@login
Scenario: An basic user logs in with the correct user name and password



@wip
@login
Scenario: An admin and basic user attempts to log in with the incorrect user name and password


@wip
@login
Scenario: An admin and basic user attempts to log in with the incorrect user name and correct password


@wip
@login
Scenario: An admin and basic user attempts to log in with the correct user name and incorrect password


@wip
@login
Scenario: An admin and basic user is locked out due to 3 incorrect log in attempts