Feature: Delete Booking API

  Background:
    Given Booking API endpoint is available
    And booking exists


  # POSITIVE SCENARIOS FOR DELETE BOOKING

  @regression @deleteBookingValid
  Scenario: Delete booking successfully
    Given user is authenticated
    When user deletes booking
    Then response status code should be 201


  # NEGATIVE SCENARIOS FOR NON-EXISTING BOOKING

  @deleteBookingNotFound
  Scenario: Delete non-existing booking
    Given user is authenticated
    When user deletes non existing booking
    Then response status code should be 404


  # ERROR VALIDATION FOR DELETE BOOKING

  @deleteBookingErrorMessage
  Scenario: Validate delete booking error
    Given user is authenticated
    When user deletes non existing booking
    Then response status code should be 404
    And error message should contain "Not Found"


  # HEADER VALIDATION FOR DELETE BOOKING

  @headerValidation @deleteBookingHeaders
  Scenario: Validate delete booking headers
    Given user is authenticated
    When user deletes booking
    Then response header "Content-Type" should be "text/plain"


  # PERFORMANCE VALIDATION FOR DELETE BOOKING RESPONSE TIME

  @performance @deleteBookingPerformance
  Scenario: Validate delete booking response time
    Given user is authenticated
    When user deletes booking
    Then response time should be less than 2000 ms