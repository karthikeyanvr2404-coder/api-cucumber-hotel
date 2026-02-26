Feature: Create Booking API

  As an API user
  I want to create bookings
  So that rooms can be reserved


  Background:
    Given Booking API endpoint is available
    And request content type is "application/json"


  # POSITIVE SCENARIOS WITH VALID DETAILS

  @regression @createBookingValid
  Scenario Outline: Create booking with valid data
    When User creates booking with "<firstname>" "<lastname>" "<price>" "<deposit>" "<checkin>" "<checkout>""<needs>"
    Then Response status should be 200
    And Response should match booking schema

    Examples:
      | firstname | lastname | price | checkin    | checkout   | needs      |
      | John      | Brown    | 100   | 2024-01-01 | 2024-01-05 | Breakfast  |
      | Alice     | Smith    | 250   | 2024-02-01 | 2024-02-10 | Lunch      |
      | Mark      | Lee      | 500   | 2024-03-01 | 2024-03-07 | Dinner     |
      | Emma      | White    | 150   | 2024-04-01 | 2024-04-05 | None       |

  @createBookingValidRoom @roomBooking
  Scenario Outline: Create booking for valid rooms
    When user creates booking for room "<room>"
    Then response status code should be 200

    Examples:
      | room |
      | 101 |
      | 102 |


  # BOUNDARY TESTING WITH IN BOUNDARY NUMBERS

  @boundaryTest @createBookingRoomBoundary
  Scenario Outline: Create booking with boundary room numbers

    When user creates booking for room "<room>"
    Then response status code should be 200

    Examples:
      | room |
      | 1    |
      | 999  |


  # NEGATIVE SCENARIOS WITH INVALID DATA

  @createBookingInvalidData @validationError
  Scenario Outline: Create booking with invalid data
    When User creates booking with "<firstname>" "<lastname>" "<price>" "<deposit>" "<checkin>" "<checkout>"<needs>"
    And the user gets "<error>" error message
    Then Response status should be <status>

    Examples:
      | firstname | lastname | price | checkin    | checkout   | needs      | status |error|
      |           | Brown    | 100   | 2024-01-01 | 2024-01-05 | Breakfast  | 200    |first name should not be blank |
      | John      |   cc      | 100   | 2024-01-01 | 2024-01-05 | Breakfast  | 200    |size must be minimum 3 to 25  |
      | John      | Brown    | 0     | 2024-01-01 | 2024-01-05 | Breakfast  | 200    |Price should not be zero price |
      | John      | Brown    | -50   | 2024-01-01 | 2024-01-05 | Breakfast  | 200    |Price must not be negative     |
      | John      | Brown    | 100   | invalid    | 2024-01-05 | Breakfast  | 200    |Invalid checkin date           |
      | John      | Brown    | 100   | 2024-01-01 | invalid    | Breakfast  | 400    |Invalid checkout date          |


  @createBookingInvalidRoom @validationError
  Scenario Outline: Create booking with invalid room numbers
    When user creates booking for room "<room>"
    Then response status code should be 400

    Examples:
      | room |
      | ABC  |
      | -1   |


  @createBookingEmptyRoom @validationError
  Scenario Outline: Create booking with empty room
    When user creates booking with empty room <room>
    Then response status code should be 400
    And error message should be "Empty Room"
    And user is unable to create a booking

    Examples:
      | room |
      |      |
      |      |




  # ERROR VALIDATION WITH INVALID ROOM

  @createBookingErrorMessage
  Scenario: Validate invalid room error message

    When user creates booking for room "ABC"
    Then response status code should be 400
    And error message should contain "room"


  # SCHEMA VALIDATION WITH VALID RESPONSE SCHEMA

  @schemaValidation @createBookingSchema
  Scenario: Validate booking response schema
    When user creates booking with valid details
    Then response status code should be 200
    And response should match booking schema


  # HEADER VALIDATION WITH CREATE BOOKING RESPONSE HEADERS

  @headerValidation @createBookingHeaders
  Scenario: Validate create booking response headers
    When user creates booking with valid details
    Then response header "Content-Type" should be "application/json"


  # PERFORMANCE VALIDATION WITH CREATE BOOKING RESPONSE TIME

  @performance @createBookingPerformance
  Scenario: Validate create booking response time

    When user creates booking with valid details
    Then response time should be less than 2000 ms


  # DATA VALIDATION WITH CREATED BOOKING

  @dataValidation @createBookingDataIntegrity
  Scenario: Validate created booking data integrity

    When user creates booking with valid details
    Then response status code should be 200
    And firstname should match request
    And lastname should match request
    And totalprice should match request


  # CONTRACT VALIDATION WITH CREATE BOOKING RESPONSE

  @contractValidation @createBookingContract
  Scenario: Validate create booking response contract

    When user creates booking with valid details
    Then response should contain field "bookingid"
    And response should contain field "booking.firstname"
    And response should contain field "booking.lastname"
    And response should contain field "booking.totalprice"