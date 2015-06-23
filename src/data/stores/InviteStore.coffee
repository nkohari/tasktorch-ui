Invite               = require 'data/models/Invite'
ModelStore           = require 'data/framework/ModelStore'
LoadInviteRequest    = require 'data/requests/LoadInviteRequest'
CreateInvitesRequest = require 'data/requests/CreateInvitesRequest'

class InviteStore extends ModelStore

  displayName: 'InviteStore'
  name:        'invites'
  modelType:   Invite

  listensFor: [
    'InvitesLoaded'
    'UserCreatedInvites'
  ]

  load: (id) ->
    @execute new LoadInviteRequest(id)

  onInvitesLoaded: (event) ->
    @add(event.invites)

  onUserCreatedInvites: (event) ->
    @execute new CreateInvitesRequest(event.orgid, event.invites)

module.exports = InviteStore
