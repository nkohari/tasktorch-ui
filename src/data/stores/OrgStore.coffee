Org                        = require 'data/models/Org'
ModelStore                 = require 'data/framework/ModelStore'
LoadOrgRequest             = require 'data/requests/LoadOrgRequest'
ChangeOrgCreditCardRequest = require 'data/requests/ChangeOrgCreditCardRequest'

class OrgStore extends ModelStore

  displayName: 'OrgStore'
  name:        'orgs'
  modelType:   Org

  listensFor: [
    'OrgsLoaded'
    'OrgChanged'
    'UserChangedOrgCreditCard'
  ]

  load: (id) ->
    @execute new LoadOrgRequest(id)

  onOrgsLoaded: (event) ->
    @add(event.orgs)

  onOrgChanged: (event) ->
    @add(event.org)

  onUserChangedOrgCreditCard: (event) ->
    @execute new ChangeOrgCreditCardRequest(event.orgid, event.token)
    
module.exports = OrgStore
