Feature: Create a function & related spec for the model

    Scenario: Enters the command with arguments
        When I run `rails_zen model act calculator sum` interactively
        When I close the stdin stream
        Then the output should contain "What does your method do?"

    Scenario: Enters what the method does
        When I run `rails_zen model act calculator sum` interactively
        And I type "returns sum of two numbers"
        #And I type "a,b"
        #And I type "1,2"
        #And I type "3"
        When I close the stdin stream
        Then the output should contain "What name would you give your arguments"

    Scenario: Enters the argument names
        When I run `rails_zen model act calculator sum` interactively
        And I type "returns sum of two numbers"
        And I type "a,b"
        #And I type "1,2"
        #And I type "3"
        When I close the stdin stream
        Then the output should contain "Give example arguments"

    Scenario: Enters the argument values
        When I run `rails_zen model act calculator sum` interactively
        And I type "returns sum of two numbers"
        And I type "a,b"
        And I type "1,2"
        #And I type "3"
        When I close the stdin stream
        Then the output should contain "Enter the expected output for the previously entered arguments. eg: 3"

    #@focus
    #Scenario: Enters the end result
        #When I run `rails_zen model act user sum` interactively
        #And I type "returns sum of two numbers"
        #And I type "a,b"
        #And I type "1,2"
        #And I type "3"
        #Then For this user model, the exit status should be 0
