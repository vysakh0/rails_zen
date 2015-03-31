Feature: Generate model related things

    Scenario: Enters the command with arguments
        When I run `rails_zen model g user name:string` interactively
        And I type "0"
        When I close the stdin stream
        Then the output should contain "0 name"

    Scenario: Selects simple attributes
        When I run `rails_zen model g user name:string phone:integer` interactively
        And I type "0"
        And I type "n"
        When I close the stdin stream
        Then the output should contain "Should :phone be present always in your record?"

    Scenario: No unique attributes and integer
        When I run `rails_zen model g user name:string phone:integer` interactively
        And I type "0"
        And I type "n"
        And I type " "
        When I close the stdin stream
        Then the output should contain "phone is an integer do you want to check"

    Scenario: No unique attributes, integer and has a relation
        When I run `rails_zen model g user name:string` interactively
        And I type "0"
        And I type "n"
        And I type "posts"
        When I close the stdin stream
        #Then the exit status should be 0
        Then the output should contain "Do you have any has_many relations?"

        #@focus
        # file writing part
    #Scenario: No unique attributes, integer and has a relation
        #When I run `rails_zen model g user name:string phone:integer` interactively
        #And I type "1"
        #And I type "n"
        #And I type "posts"
        #Then the exit status should be 0


    Scenario: No unique attributes and string
        When I run `rails_zen model g user name:string phone:integer` interactively
        And I type "1"
        And I type "n"
        And I type " "
        Then the exit status should be 0

    Scenario: not a unique attribute and a relation
        When I run `rails_zen model g user name:string phone:integer location:belongs_to` interactively
        And I type "0,1"
        And I type "y"
        Given I have all files
        And I type "0"
        Then the output should contain "0 if it is not unique"

    Scenario: unique attribute is a relation
        When I run `rails_zen model g user name:string phone:integer location:belongs_to` interactively
        And I type "0,1"
        And I type "y"
        Given I have all files
        And I type "1"
        Then the output should contain "0 if it is not unique"
