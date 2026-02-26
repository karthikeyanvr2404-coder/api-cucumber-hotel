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
      | firstname | lastname | price | deposit | checkin    | checkout   | needs     |
      | John      | Brown    | 100   | true    | 2026-03-01 | 2026-03-05 | Breakfast |
      | Alice     | Smith    | 250   | false   | 2026-04-10 | 2026-04-15 | Lunch     |
      | Mark      | Lee      | 500   | true    | 2026-05-01 | 2026-05-07 | Dinner    |
      | Emma      | White    | 150   | false   | 2026-06-01 | 2026-06-05 | None      |

  @createBookingValidRoom @roomBooking
  Scenario Outline: Create booking for valid rooms
    When user creates booking for room "<room>"
    Then response status code should be 200
    Examples:
      | room |
      | 101  |
      | 102  |
      | 201  |

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
    When User creates booking with "<firstname>" "<lastname>" "<price>" "<deposit>" "<checkin>" "<checkout>""<needs>"
    And the user gets "<error>" error message
    Then Response status should be <status>
    Examples:
      | firstname | lastname | price | deposit | checkin    | checkout   | needs     | status | error                          |
      |           | Brown    | 100   | true    | 2026-03-01 | 2026-03-05 | Breakfast | 200    | first name should not be blank |
      | Jo        | Brown    | 100   | true    | 2026-03-01 | 2026-03-05 | Breakfast | 200    | size must be between 3 and 25  |
      | John      | Brown    | 0     | true    | 2026-03-01 | 2026-03-05 | Breakfast | 200    | price should not be zero       |
      | John      | Brown    | -50   | true    | 2026-03-01 | 2026-03-05 | Breakfast | 200    | price must not be negative     |
      | John      | Brown    | 100   | true    | invalid    | 2026-03-05 | Breakfast | 200    | invalid checkin date           |
      | John      | Brown    | 100   | true    | 2026-03-01 | invalid    | Breakfast | 400    | invalid checkout date          |

  @createBookingInvalidRoom @validationError
  Scenario Outline: Create booking with invalid room numbers
    When user creates booking for room "<room>"
    Then response status code should be 400
    Examples:
      | room |
      | ABC  |
      | -1   |
      | 0    |

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
  Scenario Outline: Validate invalid room error message
    When user creates booking for room "<room>"
    Then response status code should be 400
    And error message should contain "room"
    Examples:
      | room |
      | ABC  |
      | -5   |

  # SCHEMA VALIDATION WITH VALID RESPONSE SCHEMA
  @schemaValidation @createBookingSchema
  Scenario Outline: Validate booking response schema
    When user creates booking with "<firstname>" "<lastname>" "<price>" "<deposit>" "<checkin>" "<checkout>" "<needs>"
    Then response status code should be 200
    And response should match booking schema
    Examples:
      | firstname | lastname | price | deposit | checkin    | checkout   | needs     |
      | David     | Miller   | 300   | true    | 2026-07-01 | 2026-07-05 | Breakfast |

  # HEADER VALIDATION WITH CREATE BOOKING RESPONSE HEADERS
  @headerValidation @createBookingHeaders
  Scenario Outline: Validate create booking response headers
    When user creates booking with "<firstname>" "<lastname>" "<price>" "<deposit>" "<checkin>" "<checkout>" "<needs>"
    Then response header "Content-Type" should be "application/json"
    Examples:
      | firstname | lastname | price | deposit | checkin    | checkout   | needs |
      | Sarah     | Clark    | 200   | true    | 2026-08-01 | 2026-08-05 | None  |

  # PERFORMANCE VALIDATION WITH CREATE BOOKING RESPONSE TIME
  @performance @createBookingPerformance
  Scenario Outline: Validate create booking response time
    When user creates booking with "<firstname>" "<lastname>" "<price>" "<deposit>" "<checkin>" "<checkout>" "<needs>"
    Then response time should be less than 2000 ms
    Examples:
      | firstname | lastname | price | deposit | checkin    | checkout   | needs |
      | Kevin     | Adams    | 180   | true    | 2026-09-01 | 2026-09-05 | Lunch |

  # DATA VALIDATION WITH CREATED BOOKING
  @dataValidation @createBookingDataIntegrity
  Scenario Outline: Validate created booking data integrity
    When user creates booking with "<firstname>" "<lastname>" "<price>" "<deposit>" "<checkin>" "<checkout>" "<needs>"
    Then response status code should be 200
    And firstname should match "<firstname>"
    And lastname should match "<lastname>"
    And totalprice should match "<price>"
    Examples:
      | firstname | lastname | price | deposit | checkin    | checkout   | needs     |
      | Robert    | King     | 350   | true    | 2026-10-01 | 2026-10-05 | Breakfast |

  # CONTRACT VALIDATION WITH CREATE BOOKING RESPONSE
  @contractValidation @createBookingContract
  Scenario Outline: Validate create booking response contract
    When user creates booking with "<firstname>" "<lastname>" "<price>" "<deposit>" "<checkin>" "<checkout>" "<needs>"
    Then response should contain field "bookingid"
    And response should contain field "booking.firstname"
    And response should contain field "booking.lastname"
    And response should contain field "booking.totalprice"
    Examples:
      | firstname | lastname | price | deposit | checkin    | checkout   | needs |
      | Daniel    | Scott    | 275   | true    | 2026-11-01 | 2026-11-05 | None  |