Org            = require 'data/models/Org'
ModelStore     = require 'data/framework/ModelStore'
LoadOrgRequest = require 'data/requests/LoadOrgRequest'

class OrgStore extends ModelStore

  displayName: 'OrgStore'
  name:        'orgs'
  modelType:   Org

  listensFor: [
    'OrgsLoaded'
  ]

  load: (id) ->
    @execute new LoadOrgRequest(id)

  onOrgsLoaded: (event) ->
    @add(event.orgs)
    
module.exports = OrgStore
