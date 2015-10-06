Invite             = require 'data/models/Invite'
InviteCreatedEvent = require 'events/create/InviteCreatedEvent'
Request            = require 'data/framework/Request'

class CreateInviteRequest extends Request

  constructor: (@orgid, @invites) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{@orgid}/invites"))
    .withCredentials()
    .send {@invites}
  
  onSuccess: (result, publish) ->
    invites = _.map result.invites, (invite) -> new Invite(invite)
    for invite in invites
      publish new InviteCreatedEvent(invite)

module.exports = CreateInviteRequest
