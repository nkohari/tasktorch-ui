_     = require 'lodash'
Store = require '../../framework/Store'

class OrganizationStore extends Store

  constructor: ->
    @currentOrganization = undefined

  onWorkspaceLoaded: (event) ->
    @currentOrganization = event.workspace.organization
    @announce()

module.exports = OrganizationStore
