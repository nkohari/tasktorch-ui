superagent      = require 'superagent'
Org             = require 'data/models/Org'
OrgChangedEvent = require 'events/change/OrgChangedEvent'
Request         = require 'data/framework/Request'

class AddLeaderToOrgRequest extends Request

  constructor: (@orgid, @userid) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{@orgid}/leaders"))
    .withCredentials()
    .send {user: @userid}
    .end (err, res) =>
      org = new Org(res.body.org)
      eventQueue.publish new OrgChangedEvent(org)

module.exports = AddLeaderToOrgRequest
