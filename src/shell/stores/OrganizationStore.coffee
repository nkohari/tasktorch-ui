_     = require 'lodash'
Store = require 'framework/Store'

class OrganizationStore extends Store

  constructor: ->
    @currentOrganization = undefined
    @organizations = {}

  getOrganization: (id) ->
    @organizations[id]

  getAllOrganizations: ->
    _.values(@organizations)

  onOrganizationsLoaded: (event) ->
    @organizations = _.extend @organizations, _.indexBy(event.organizations, 'id')
    @announce()
    
module.exports = OrganizationStore
