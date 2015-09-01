Invite             = require 'data/models/Invite'
Request            = require 'data/framework/Request'
InvitesLoadedEvent = require 'events/load/InvitesLoadedEvent'

class LoadInviteRequest extends Request

  constructor: (@inviteid) ->

  create: (agent) ->
    agent
    .get(@urlFor("/invites/#{@inviteid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    invite = new Invite(result.invite)
    publish new InvitesLoadedEvent([invite])

module.exports = LoadInviteRequest
