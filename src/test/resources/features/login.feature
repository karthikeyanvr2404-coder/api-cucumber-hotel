Feature: Authentication API

  As an API user
  I want to authenticate
  So that I can access secured booking APIs

  Background:
    Given Booking API endpoint is available
    And request content type is "application/json"


  #POSITIVE SCENARIOS
  @regression
  @positive @login
    Scenario: Login with valid credentials
      When user logs in with valid username and password
      Then response status code should be 200
      And auth token should be generated

  @positive @login
    Scenario: Login multiple times successfully
      When user logs in with valid username and password
      Then response status code should be 200


  #NEGATIVE SCENARIOS

  @negative @login
    Scenario: Login with invalid username
     When user logs in with invalid username
     Then response status code should be 200
     And error message should contain "Bad credentials"

  @negative @login
  Scenario: Login with invalid password
    When user logs in with invalid password
    Then response status code should be 200
    And error message should contain "Bad credentials"

  @negative @login
  Scenario: Login with empty credentials
    When user logs in with empty credentials
    Then response status code should be 200
    And error message should contain "Bad credentials"


  #BOUNDARY TESTING

  @boundary @login
  Scenario: Login with minimum username length
    When user logs in with username "a"
    Then response status code should be 200


  @boundary @login
  Scenario: Login with long username
    When user logs in with long username
    Then response status code should be 200


  #HEADER VALIDATION

  @header @login
  Scenario: Validate login headers
    When user logs in with valid username and password
    Then response header "Content-Type" should be "application/json"

  #RESPONSE TIME VALIDATION

  @performance @login
  Scenario: Validate login response time
    When user logs in with valid username and password
    Then response time should be less than 2000 ms

  #SCHEMA VALIDATION

  @schema @login
    Scenario: Validate login response schema
      When user logs in with valid username and password
      Then response should match auth schema

  #CONTRACT VALIDATION

  @contract @login
     Scenario: Validate login contract
       When user logs in with valid username and password
       Then response should contain field "token"