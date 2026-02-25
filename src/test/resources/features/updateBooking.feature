Feature: Update Booking API


  Background:
    Given Booking API endpoint is available
    And booking exists


 #POSITIVE
  @regression
  @positive
  Scenario: Update booking successfully
    Given user is authenticated
    When user updates booking
    Then response status code should be 200

 @positive @room
   Scenario: Update booking room number
     Given user is authenticated
     When user updates booking room to "105"
     Then response status code  should be 200

 #NEGATIVE

  @negative @room
    Scenario: Update booking with invalid room
      Given user is authenticated
      When user updates booking room to "ABC"
      Then response status code should be 400

  #ERROR VALIDATION

  @errorValidation @room
    Scenario: Validate invalid room update error
       Given user is authenticated
       When user updates booking room to "ABC"
       Then response status code should be 400
       And error message should contain "room"

  #SCHEMA VALIDATION

  @schema @room
    Scenario: Validate update schema with room
       Given user is authenticated
       When user updates booking room to "101"
       Then response should match booking schema

  #HEADER VALIDATION

  @headers
  Scenario: Validate headers for update booking
    Given user is authenticated
    When user updates booking
    Then response header "Content-Type" should be "application/json"

  #RESPONSE TIME VALIDATION

  @performance
  Scenario: Validate update booking response time
    Given user is authenticated
    When user updates booking
    Then response time should be less than 2000 ms

 #DATA VALIDATION

  @dataValidation
  Scenario: Validate updated booking data
    Given user is authenticated
    When user updates booking
    Then firstname should match request
    And lastname should match request
    And totalprice should match request

 #CONTRACT VALIDATION

  @contract
  Scenario: Validate update booking contract
    Given user is authenticated
    When user updates booking
    Then response should contain field "firstname"
    And response should contain field "lastname"
    And response should contain field "totalprice"