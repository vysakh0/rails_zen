Feature: Generate model related things

  Scenario: Greet the user with a list of attributes to make a choice from
    When I successfully run `rails_zen model g user name:string`
    Then the output should contain "0 name"
