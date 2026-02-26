Feature: End-to-End Booking Flow
  As an API user
  I want to complete the booking lifecycle
  So that the booking system works correctly
  Background:
    Given Booking API endpoint is available
    And request content type is "application/json"

  # COMPLETE BOOKING FLOW LIFECYCLE
  @regression @e2eLifecycle
  Scenario Outline: Complete booking lifecycle
    Given user logs in with username "<username>" and password "<password>"
    And auth token should be generated
    When user creates booking with firstname "<firstname>" and lastname "<lastname>"
    Then response status code should be 200
    And booking id should be generated
    When user gets booking by id
    Then response status code should be 200
    When user updates booking firstname to "<updatedFirstname>"
    Then response status code should be 200
    When user deletes booking
    Then response status code should be 201
    Examples:
      | username | password    | firstname | lastname | updatedFirstname |
      | admin    | password123 | John      | Brown    | Johnny           |
      | admin    | password123 | Alice     | Smith    | Alicia           |

  # ROOM BOOKING FLOW WITH ROOM AND ID AND UPDATE AND DELETE ROOM
  @e2eRoomLifecycle
  Scenario Outline: Complete booking lifecycle with room "<room>"
    Given user logs in with username "<username>" and password "<password>"
    And auth token should be generated
    When user creates booking for room "<room>"
    Then response status code should be 200
    When user gets booking by id
    Then response should contain room details
    When user updates booking room to "<updatedRoom>"
    Then response status code should be 200
    When user deletes booking
    Then response status code should be 201
    Examples:
      | username | password    | room | updatedRoom |
      | admin    | password123 | 101  | 105         |
      | admin    | password123 | 102  | 110         |
      | admin    | password123 | 1    | 2           |

  # NEGATIVE FLOW WITHOUT AUTHENTICATION
  @security @e2eUnauthorized
  Scenario Outline: Booking lifecycle without authentication
    When user creates booking with firstname "<firstname>"
    Then response status code should be 200
    When user updates booking without authentication
    Then response status code should be 403
    When user deletes booking without authentication
    Then response status code should be 403
    Examples:
      | firstname |
      | John      |
      | Alice     |
      | Mark      |

  # PERFORMANCE FLOW WITH VALID DETAILS
  @performance @e2ePerformance
  Scenario Outline: End-to-end booking performance
    Given user logs in with username "<username>" and password "<password>"
    When user creates booking with firstname "<firstname>"
    Then response time should be less than 2000 ms

    Examples:
      | username | password    | firstname |
      | admin    | password123 | John      |
      | admin    | password123 | Alice     |
      | admin    | password123 | Mark      |