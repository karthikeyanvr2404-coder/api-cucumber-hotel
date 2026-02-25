Feature: Get Booking API

  Background:
    Given Booking API endpoint is available


  # POSITIVE SCENARIOS FOR GET BOOKING SUCCESSFULLY

  @regression @getBookingById @getBookingByName
  Scenario Outline: Get booking successfully

    Given booking exists
    When user gets booking by <type>
    Then response status code should be 200

    Examples:
      | type |
      | id   |
      | name |


  @getBookingRoomDetails
  Scenario: Get booking room details

    Given booking exists
    When user gets booking by id
    Then response should contain room details


  # NEGATIVE SCENARIOS WITH INVALID DATA

  @getBookingInvalidData
  Scenario Outline: Get booking with invalid values
    When user gets booking by invalid <type>
    Then response status code should be 404

    Examples:
      | type |
      | id   |
      | name |


  @negative @room
  Scenario: Get booking with invalid room id

    When user gets booking with invalid id
    Then response status code should be 404


  # ERROR VALIDATION WITH NON EXISTING BOOKING

  @@getBookingErrorMessage
  Scenario: Validate booking not found error
    When user gets booking with invalid id
    Then response status code should be 404
    And error message should contain "Not Found"


  # SCHEMA VALIDATION WITH VALID BOOKING RESPONSE

  @schemaValidation @getBookingSchema
  Scenario: Validate booking schema
    Given booking exists
    When user gets booking by id
    Then response should match booking schema


  # HEADER VALIDATION WITH GET BOOKING

  @headerValidation @getBookingHeaders
  Scenario: Validate get booking headers
    Given booking exists
    When user gets booking by id
    Then response header "Content-Type" should be "application/json"


  # PERFORMANCE VALIDATION WITH GET BOOKING RESPONSE TIME

  @performance @getBookingPerformance
  Scenario: Validate get booking response time

    Given booking exists
    When user gets booking by id
    Then response time should be less than 2000 ms


  # DATA VALIDATION WITH BOOKING RESPONSE DATA

  @dataValidation @getBookingData
  Scenario: Validate booking response data
    Given booking exists
    When user gets booking by id
    Then response should contain field "firstname"
    And response should contain field "lastname"
    And response should contain field "totalprice"
    And response should contain field "bookingdates"


  # CONTRACT VALIDATION WITH VALID BOOKING

  @contractValidation @getBookingContract
  Scenario: Validate booking contract
    Given booking exists
    When user gets booking by id
    Then response should contain field "firstname"
    And response should contain field "lastname"
    And response should contain field "bookingdates.checkin"
    And response should contain field "bookingdates.checkout"