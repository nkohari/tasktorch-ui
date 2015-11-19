Org                        = require 'data/models/Org'
ModelStore                 = require 'data/framework/ModelStore'
LoadOrgRequest             = require 'data/requests/LoadOrgRequest'
CancelAccountRequest       = require 'data/requests/CancelAccountRequest'
ReactivateAccountRequest   = require 'data/requests/ReactivateAccountRequest'
ChangeOrgCreditCardRequest = require 'data/requests/ChangeOrgCreditCardRequest'
ChangeOrgDiscountRequest   = require 'data/requests/ChangeOrgDiscountRequest'
ChangeOrgEmailRequest      = require 'data/requests/ChangeOrgEmailRequest'

class OrgStore extends ModelStore

  displayName: 'OrgStore'
  name:        'orgs'
  modelType:   Org

  listensFor: [
    'OrgsLoaded'
    'OrgChanged'
    'UserChangedOrgCreditCard'
    'UserChangedOrgDiscount'
    'UserChangedOrgEmail'
    'UserCancelledAccount'
    'UserReactivatedAccount'
  ]

  load: (id) ->
    @execute new LoadOrgRequest(id)

  onOrgsLoaded: (event) ->
    @add(event.orgs)

  onOrgChanged: (event) ->
    @add(event.org)

  onUserChangedOrgCreditCard: (event) ->
    @execute new ChangeOrgCreditCardRequest(event.orgid, event.token)
  
  onUserChangedOrgDiscount: (event) ->
    @execute new ChangeOrgDiscountRequest(event.orgid, event.discount)
  
  onUserChangedOrgEmail: (event) ->
    @execute new ChangeOrgEmailRequest(event.orgid, event.email)

  onUserCancelledAccount: (event) ->
    @execute new CancelAccountRequest(event.orgid, event.reason)

  onUserReactivatedAccount: (event) ->
    @execute new ReactivateAccountRequest(event.orgid)
    
module.exports = OrgStore
