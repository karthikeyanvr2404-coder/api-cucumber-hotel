Feature: Create Booking API

  As an API user
  I want to create bookings for rooms
  So that rooms can be reserved

  Background:
    Given Booking API endpoint is available
    And request content type is "application/json"

    #POSITIVE SCENARIOS

  @positive
  Scenario: Create booking with valid details
    When  user creates booking with valid details
    Then response status code should be 200
    And booking id should be generated

  @positive @room
  Scenario: Create booking for a valid room
    When user creates booking for room "101"
    Then response status code should be 200

  @positive @room
  Scenario: Create booking for a different rooms
    When user creates booking for room "102"
    Then response status code should be 200

    #ROOM BOUNDARY TESTS
  @boundary @room
    Scenario: Create booking with minimum room number
    When user creates booking for room "1"
    Then response status code should be 200

  @boundary @room
  Scenario: Create booking with maximum room number
    When user creates booking for room "999"
    Then response status code should be 200


    #ROOM NEGATIVE TESTS

  @negative @room
    Scenario: Create booking with invalid room number
    When user creates booking for room "ABC"
    Then response status code should be 400

  @negative @room
  Scenario: Create booking with negative room number
    When user creates booking for room "-1"
    Then response status code should be 400

  @negative @room
  Scenario: Create booking with empty room
    When user creates booking with empty room
    Then response status code should be 400

    #ROOM ERROR VALIDATION
  @errorValidation @room
    Scenario: Validate invalid room error
    When user creates booking for room "ABC"
    Then response status code should be 400
    And error message should contain "room"

    #ROOM SCHEMA VALIDATION

  @schema @room
    Scenario: Validate booking schema with room
    When user creates booking for room "101"
    Then response status code should be 200
    And response should match booking schema

    #HEADER VALIDATION


    @headers
    Scenario: Validate response headers for create booking
      When user creates booking with valid details
      Then response header "Content-Type" should be "application/json"

   #RESPONSE TIME VALIDATION

    @performance
    Scenario: Validate create booking response time
      When user creates booking with valid details
      Then response time should be less than 2000ms

   #DATA INTEGRITY VALIDATION

    @dataValidation

    Scenario: Validate created booking data integrity
      When user creates booking with valid details
      Then response status code should be 200
      And firstname should match request
      And lastname should match request
      And totalprice should match request


  #CONTRACT VALIDATION

    @contract

    Scenario: Validate create booking response contract
      When user creates booking with valid details
      Then response should contain field "bookingid"
      And response should contain field "booking.firstname"
      And response should contain field "booking.lastname"
      And response should contain field "booking.totalprice"






