# ----------------------------------------------------------------------------
Feature: Test the Cats service
# Copied from the karate-netty docs with minor adjustments
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
Background:
# ----------------------------------------------------------------------------
    * url baseURL

# ----------------------------------------------------------------------------
Scenario: create cats and validate the results
# ----------------------------------------------------------------------------
    Given path "cats"
    And request { name: 'Billie' }
    When method post
    Then status 201    
    And match response == { id: '#uuid', name: 'Billie' }
    And def id = response.id

    Given path "cats", id
    When method get
    Then status 200
    And match response == { id: '#(id)', name: 'Billie' }

    Given path "cats"
    When method get
    Then status 200
    And match response contains [{ id: '#(id)', name: 'Billie' }]

    Given path "cats"
    And request { name: 'Bob' }
    When method post
    Then status 201
    And match response == { id: '#uuid', name: 'Bob' }
    And def id = response.id

    Given path "cats", id
    When method get
    Then status 200
    And match header Content-Type == 'application/json'
    And match response == { id: '#(id)', name: 'Bob' }

    Given path "cats", id
    And header Accept = 'text/xml'
    When method get
    Then status 200
    And match header Content-Type == 'text/xml'
    And match response /cat/id == '#uuid'
    And match response /cat/name == 'Bob'

    Given path "cats"
    When method get
    Then status 200
    And match response contains only [{ id: '#uuid', name: 'Billie' },{ id: '#(id)', name: 'Bob' }]

    Given path "cats/1234"
    When method get
    Then status 404