  Feature: Delete Booking API

    Background:
      Given Booking API endpoint is available
      And booking exists

  #POSITIVE
    @regression
    @positive
    Scenario: Delete booking successfully
      Given user is authenticated
      When user deletes booking
      Then response status code should be 201



    @positive @room
    Scenario: Delete room booking
      Given user is authenticated
      And booking exists
      When user deletes booking
      Then response status code should be 201

  #NEGATIVE

    @negative @room
     Scenario: Delete non existing room booking
      Given user is authenticated
      When user deletes non existing booking
      Then response status code should be 404

  #ERROR VALIDATION

    @errorValidation @room
      Scenario: Validate room delete error
      Given user is authenticated
      When user deletes non existing booking
      Then response status code should be 404
      And error message should contain "Not Found"


  #HEADER VALIDATION

    @headers
    Scenario: Validate headers for delete booking
      Given user is authenticated
      When user deletes booking
      Then response header "Content-Type" should be "text/plain"

  #RESPONSE TIME VALIDATION

    @performance
    Scenario: Validate delete booking response time
      Given user is authenticated
      When user deletes booking
      Then response time should be less than 2000 ms

  #CONTRACT VALIDATION

    @performance
    Scenario: Validate delete booking response time
      Given user is authenticated
      When user deletes booking
      Then response time should be less than 2000 ms