superagent         = require 'superagent'
Invite             = require 'data/models/Invite'
InviteCreatedEvent = require 'events/create/InviteCreatedEvent'
Request            = require 'data/framework/Request'

class CreateInviteRequest extends Request

  constructor: (@orgid, @invites) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{@orgid}/invites"))
    .withCredentials()
    .send({@invites})
    .end (err, res) =>
      invites = _.map res.body.invites, (invite) -> new Invite(invite)
      for invite in invites
        eventQueue.publish new InviteCreatedEvent(invite)

module.exports = CreateInviteRequest
