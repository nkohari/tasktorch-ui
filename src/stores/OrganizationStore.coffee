_     = require 'lodash'
Store = require 'framework/Store'

class OrganizationStore extends Store

  onOrganizationsLoaded: (event) ->
    @add(event.organizations)
    
module.exports = OrganizationStore
