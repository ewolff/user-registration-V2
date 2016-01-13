Narrative:
To use the wbsite
As a customer
I want to register
So that I can login

Scenario: User registers successfully

Given a new user with email eberhard.wolff@gmail.com firstname Eberhard name Wolff
When the user registers
Then a user with email eberhard.wolff@gmail.com should exist
And no error should be reported

Scenario: Invalid email 

Given a new user with email HURZ firstname Eberhard name Wolff
When the user registers
Then an error should be reported

Scenario: Only one user with an email

Given a new user with email eberhard.wolff@gmail.com firstname Eberhard name Wolff
And another user with email eberhard.wolff@gmail.com firstname Bill name Gates
When the user registers
And the other user registers
Then the registration of the other user should fail

Scenario: User does not exist after deletion

Given a new user with email eberhard.wolff@gmail.com firstname Eberhard name Wolff
When the user registers
And the user is deleted
Then no user with email eberhard.wolff@gmail.com should exist