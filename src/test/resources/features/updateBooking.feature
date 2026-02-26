Feature: Update Booking API
  Background:
    Given Booking API endpoint is available
    And booking exists

  # POSITIVE SCENARIOS FOR UPDATE VALID BOOKING AND ROOM
  @regression @updateBookingValid
  Scenario Outline: Update booking successfully
    Given user is authenticated
    When user updates booking <firstname>
    Then response status code should be 200
    Examples:
      | firstname   |
      | Abraham     |
      | Alice steve |
      | John        |

  @updateBookingRoomValid
  Scenario Outline: Update booking room number
    Given user is authenticated
    When user updates booking room to "<room>"
    Then response status code should be 200
    Examples:
      | room |
      | 101  |
      | 105  |
      | 110  |

  # NEGATIVE SCENARIOS FOR INVALID BOOKING
  @updateBookingRoomInvalid
  Scenario Outline: Update booking with invalid room
    Given user is authenticated
    When user updates booking room to "<room>"
    Then response status code should be 400
    Examples:
      | room |
      | ABC  |
      | -1   |
      | 0    |
      | 9999 |

  # ERROR VALIDATION FOR INVALID ROOM UPDATE
  @updateBookingErrorMessage
  Scenario Outline: Validate invalid room update error
    Given user is authenticated
    When user updates booking room to "<room>"
    Then response status code should be 400
    And error message should contain "room"
    Examples:
      | room |
      | ABC  |
      | -10  |

  # SCHEMA VALIDATION FOR UPDATE BOOKING SCHEMA
  @schemaValidation @updateBookingSchema
  Scenario: Validate update booking schema
    Given user is authenticated
    When user updates booking
    Then response should match booking schema

    # HEADER VALIDATION FOR UPDATE BOOKING
  @headerValidation @updateBookingHeaders
  Scenario: Validate update booking headers
    Given user is authenticated
    When user updates booking
    Then response header "Content-Type" should be "application/json"

  # PERFORMANCE VALIDATION UPDATE BOOKING RESPONSE TIME
  @performance @updateBookingPerformance
  Scenario: Validate update booking response time
    Given user is authenticated
    When user updates booking
    Then response time should be less than 2000 ms

  # DATA VALIDATION WITH UPDATED BOOKING DATA
  @dataValidation @updateBookingData
  Scenario Outline: Validate updated booking data
    Given user is authenticated
    When user updates booking firstname to "<firstname>"
    Then firstname should match request
    And lastname should match request
    And totalprice should match request
    Examples:
      | firstname |
      | Michael   |
      | Robert    |
      | Anderson  |

  # CONTRACT VALIDATION WITH UPDATE BOOKING
  @contractValidation @updateBookingContract
  Scenario Outline: Validate update booking contract
    Given user is authenticated
    When user updates booking with valid data
    Then response should contain field "<field>"
    Examples:
      | field        |
      | firstname    |
      | lastname     |
      | totalprice   |
      | bookingdates |
      | checkin      |
      | checkout     |