Feature: Exploratory Testing for Booking and Room APIs

  As an API user
  I want to perform exploratory testing
  So that unexpected system behaviors can be identified


  Background:
    Given Booking API endpoint is available
    And request content type is "application/json"


  # BOOKING EXPLORATORY TESTS WITH UNUSUAL INPUT VALUES

  @exploratoryLargePayload
  Scenario Outline: Create booking with unusual input values
    When user creates booking with "<inputType>" values
    Then response status code should be <status>

    Examples:
      | inputType            | status |
      | very large text      | 400    |
      | special characters   | 400    |
      | null values          | 400    |
      | numeric firstname    | 200    |



  # INVALID REQUEST TESTS WITH INVALID REQUEST BODY

  @exploratoryInvalidBody
  Scenario Outline: Create booking with invalid request body
    When user sends "<requestType>" booking request
    Then response status code should be 400

    Examples:
      | requestType     |
      | empty           |
      | invalid JSON    |



  # ROOM EXPLORATORY TESTS WITH UNUSUAL ROOD ID

  @exploratoryRoomIds
  Scenario Outline: Get room with unusual room id values
    When user gets room with "<roomType>" id
    Then response status code should be <status>

    Examples:
      | roomType | status |
      | invalid  | 404 |
      | negative | 404 |



  # BOOKING STATE TESTS BY DELETING BOOKING TWICE

  @exploratoryStateTest
  Scenario: Delete booking twice
    Given user creates booking with valid data
    When user deletes booking
    Then response status code should be 201
    When user deletes booking again
    Then response status code should be 404



  # SECURITY TESTS WITHOUT AUTHENTICATION

  @exploratorySecurity
  Scenario Outline: Booking operations without authentication
    Given user creates booking with valid data
    When user <operation> booking without authentication
    Then response status code should be 403

    Examples:
      | operation |
      | updates |
      | deletes |