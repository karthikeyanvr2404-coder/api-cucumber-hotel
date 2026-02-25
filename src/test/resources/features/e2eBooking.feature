Feature: End-to-End Booking Flow

  As an API user
  I want to complete the booking lifecycle
  So that the booking system works correctly


  Background:
    Given Booking API endpoint is available
    And request content type is "application/json"


  # COMPLETE BOOKING FLOW LIFECYCLE

  @regression @e2eLifecycle
  Scenario: Complete booking lifecycle

    Given user logs in with valid username and password
    And auth token should be generated

    When user creates booking with valid details
    Then response status code should be 200
    And booking id should be generated

    When user gets booking by id
    Then response status code should be 200

    When user updates booking
    Then response status code should be 200

    When user deletes booking
    Then response status code should be 201



  # ROOM BOOKING FLOW WITH ROOM AND ID AND UPDATE AND DELETE ROOM

  @e2eRoomLifecycle
  Scenario Outline: Complete booking lifecycle with room "<room>"

    Given user logs in with valid username and password
    And auth token should be generated

    When user creates booking for room "<room>"
    Then response status code should be 200

    When user gets booking by id
    Then response should contain room details

    When user updates booking room to "<updatedRoom>"
    Then response status code should be 200

    When user deletes booking
    Then response status code should be 201

    Examples:
      | room | updatedRoom |
      | 101  | 105 |
      | 102  | 110 |



  # NEGATIVE FLOW WITHOUT AUTHENTICATION

  @security @e2eUnauthorized
  Scenario: Booking lifecycle without authentication

    When user creates booking with valid details
    Then response status code should be 200

    When user updates booking without authentication
    Then response status code should be 403

    When user deletes booking without authentication
    Then response status code should be 403



  # PERFORMANCE FLOW WITH VALID DETAILS

  @performance @e2ePerformance
  Scenario: End-to-end booking performance
    Given user logs in with valid username and password
    When user creates booking with valid details
    Then response time should be less than 2000 ms