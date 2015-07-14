superagent      = require 'superagent'
Org             = require 'data/models/Org'
OrgChangedEvent = require 'events/change/OrgChangedEvent'
Request         = require 'data/framework/Request'

class RemoveLeaderFromOrgRequest extends Request

  constructor: (@orgid, @userid) ->

  execute: (eventQueue) ->
    superagent.del(@urlFor("/#{@orgid}/leaders/#{@userid}"))
    .withCredentials()
    .end (err, res) =>
      org = new Org(res.body.org)
      eventQueue.publish new OrgChangedEvent(org)

module.exports = RemoveLeaderFromOrgRequest
