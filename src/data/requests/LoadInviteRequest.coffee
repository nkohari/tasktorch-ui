superagent         = require 'superagent'
Invite             = require 'data/models/Invite'
Request            = require 'data/framework/Request'
InvitesLoadedEvent = require 'events/load/InvitesLoadedEvent'

class LoadInviteRequest extends Request

  constructor: (@inviteid) ->

  execute: (eventQueue) ->
    superagent.get(@urlFor("/invites/#{@inviteid}"))
    .withCredentials()
    .end (err, res) =>
      invite = new Invite(res.body.invite)
      eventQueue.publish new InvitesLoadedEvent([invite])

module.exports = LoadInviteRequest
