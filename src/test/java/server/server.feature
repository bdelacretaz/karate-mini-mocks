# ----------------------------------------------------------------------------
Feature: Stateful mock server for cats
# Copied from the karate-netty docs with minor adjustments
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
Background:
# ----------------------------------------------------------------------------
* def uuid = function(){ return java.util.UUID.randomUUID() + '' }
* def cats = {}
* def abortWithStatus = 
"""
function(status) 
{ 
    karate.set("responseStatus", status) ; 
    karate.abort(); 
}
"""

# ----------------------------------------------------------------------------
Scenario: pathMatches('/cats') && methodIs('post')
# ----------------------------------------------------------------------------
    * def cat = request
    * def id = uuid()
    * set cat.id = id
    * eval cats[id] = cat
    * def response = cat
    * def responseStatus = 201

# ----------------------------------------------------------------------------
Scenario: pathMatches('/cats')
# ----------------------------------------------------------------------------
    * def response = $cats.*

# ----------------------------------------------------------------------------
Scenario: pathMatches('/cats/{id}')
# ----------------------------------------------------------------------------
    * def result = cats[pathParams.id]
    * eval if(!result) abortWithStatus(404)
    * def response = result

# ----------------------------------------------------------------------------
Scenario:
# ----------------------------------------------------------------------------
    * def responseStatus = 404