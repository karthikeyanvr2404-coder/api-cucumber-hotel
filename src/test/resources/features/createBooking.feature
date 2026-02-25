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
  Scenario: Create booking for a valid room
    When user creates booking for room "102"
    Then response status code should be 200