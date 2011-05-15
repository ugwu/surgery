Feature: User

As an admin user,
I want to be able to add other users to the system,
So that I am not the only one who can use the system

@user
Scenario Outline: An admin user adds another user to the system

Given that I am logged in as an admin user
And I am on the add user page
When I add an "<type>" user 
Then I should see "<message>"

Scenarios:

 | type  | message                        |
 | admin | You have created an admin user |
 | basic | You have created a basic user  |

 
