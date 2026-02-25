Feature: End To End Booking Flow

  As an API user
  I want to complete booking lifecycle
  So that the booking system works correctly


  Background:
    Given Booking API endpoint is available
    And request content type is "application/json"


#COMPLETE BOOKING FLOW
  @regression
  @e2e
  Scenario: Complete booking lifecycle
    Given user logs in with valid username and password
    Then auth token should be generated

    When user creates booking with valid details
    Then response status code should be 200
    And booking id should be generated

    When user gets booking by id
    Then response status code should be 200

    When user updates booking
    Then response status code should be 200

    When user deletes booking
    Then response status code should be 201

#E2E ROOM FLOW

  @e2e @room
    Scenario: Complete booking lifecycle with room

    Given user logs in with valid username and password
    Then auth token should be generated

    When user creates booking for room "101"
    Then response status code should be 200

    When user gets booking by id
    Then response should contain room details

    When user updates booking room to "105"
    Then response status code should be 200

    When user deletes booking
    Then response status code should be 201

#E2E NEGATIVE FLOW

  @e2eNegative
  Scenario: E2E booking without authentication

    When user creates booking with valid details
    Then response status code should be 200

    When user updates booking without authentication
    Then response status code should be 403

    When user deletes booking without authentication
    Then response status code should be 403

#E2E PERFORMANCE

  @e2ePerformance
  Scenario: E2E booking performance

    Given user logs in with valid username and password
    When user creates booking with valid details
    Then response time should be less than 2000 ms