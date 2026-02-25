Feature: Exploratory Testing for Booking and Room APIs

  As an API user
  I want to exploratory testing
  So that I can access some extraordinary unexpected values

  Background:
    Given Booking API endpoint is available
    And request content type is "application/json"


  @exploratory @booking
  Scenario: Create booking with extremely long values
    When User creates booking with very large text values
    Then Status code should be 400 or 500



  @exploratory @booking
  Scenario: Create booking with special characters
    When User creates booking with special characters
    Then Status code should be 400 or 201



  @exploratory @booking
  Scenario: Create booking with numeric values in name
    When User creates booking with numeric firstname
    Then Status code should be validated



  @exploratory @booking
  Scenario: Create booking with null values
    When User creates booking with null values
    Then Status code should be 400



  @exploratory @booking
  Scenario: Create booking with empty JSON body
    When User sends empty booking request
    Then Status code should be 400



  @exploratory @booking
  Scenario: Create booking with invalid JSON structure
    When User sends invalid booking JSON
    Then Status code should be 400



  @exploratory @room
  Scenario: Get room with invalid ID
    When User gets room with invalid id
    Then Status code should be 404



  @exploratory @room
  Scenario: Get room with negative ID
    When User gets room with negative id
    Then Status code should be 400 or 404



  @exploratory @booking
  Scenario: Delete booking twice
    Given User creates booking with valid data
    When User deletes the booking
    Then Status code should be 202
    When User deletes the same booking again
    Then Status code should be 404



  @exploratory @booking
  Scenario: Update booking without authentication
    Given User creates booking with valid data
    When User updates booking without token
    Then Status code should be 403



  @exploratory @booking
  Scenario: Delete booking without authentication
    Given User creates booking with valid data
    When User deletes booking without token
    Then Status code should be 403