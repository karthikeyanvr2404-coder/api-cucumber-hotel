Feature: Authentication API
  Background:
    Given Booking API endpoint is available
    And request content type is "application/json"

  # POSITIVE SCENARIOS WITH LOGIN VALID
  @regression @loginValid
  Scenario: Login successfully
    When user logs in with valid username and password
    Then response status code should be 200
    And auth token should be generated

  # NEGATIVE SCENARIOS WITH INVALID CREDENTIALS
  @loginInvalidCredentials
  Scenario Outline: Login with invalid credentials
    When user logs in with <type>
    Then response status code should be 200
    And error message should contain "Bad credentials"
    Examples:
      | type |
      | invalid username |
      | invalid password |
      | empty credentials |

  # SCHEMA VALIDATION FOR LOGIN
  @schema @login
  Scenario: Validate login schema
    When user logs in with valid username and password
    Then response should match auth schema

  # PERFORMANCE TO VALIDATE LOGIN RESPONSE TIME
  @performance @login
  Scenario: Validate login response time
    When user logs in with valid username and password
    Then response time should be less than 2000 ms