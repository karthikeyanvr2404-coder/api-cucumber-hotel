Feature: Get Booking API

  Background:
    Given Booking API endpoint is available

    #POSITIVE

  @positive
  Scenario: Get booking by name
    Given booking exists
    When user gets bookin by name
    Then response status code should be 200

    Scenario: Get booking by id
      Given booking exists
      When user gets booking by id
      Then response status code should be 200

  @positive @room
    Scenario: Get booking room details
      Given booking exists
      When user gets booking  by id
      Then response should contain room details

  #NEGATIVE

  @negative
  Scenario: Get booking by invalid name
    When user gets booking by invalid name
    Then response status code should be 404

  Scenario: Get booking by id
    When user gets bookin by id
    Then response status code should be 404

  @negative @room
   Scenario: Get booking with invalid room id
    When user gets booking with invalid id
    Then response status code should be 404

 #ERROR VALIDATION

  @errorValidation @room

    Scenario: Validate room booking not found error
     When user gets booking with invalid id
     Then response status code should be 404
     And error message should contain "Not Found"

 #SCHEMA VALIDATION

  @schema @room
    Scenario: Validate booking schema contains room
     Given booking exists
     When user gets booking by id
     Then response should match booking schema

 #HEADER VALIDATION

  @headers
  Scenario: Validate headers for get booking
    Given booking exists
    When user gets booking by id
    Then response header "Content-Type" should be "application/json"

 #RESPONSE TIME VALIDATION

  @performance
  Scenario: Validate get booking response time
    Given booking exists
    When user gets booking by id
    Then response time should be less than 2000 ms

 #DATA VALIDATION

  @dataValidation
  Scenario: Validate booking data fields
    Given booking exists
    When user gets booking by id
    Then response should contain field "firstname"
    And response should contain field "lastname"
    And response should contain field "totalprice"
    And response should contain field "bookingdates"

 #CONTRACT VALIDATION

  @contract
  Scenario: Validate get booking contract
    Given booking exists
    When user gets booking by id
    Then response should contain field "firstname"
    And response should contain field "lastname"
    And response should contain field "bookingdates.checkin"
    And response should contain field "bookingdates.checkout"


