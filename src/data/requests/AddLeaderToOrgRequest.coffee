Org             = require 'data/models/Org'
OrgChangedEvent = require 'events/change/OrgChangedEvent'
Request         = require 'data/framework/Request'

class AddLeaderToOrgRequest extends Request

  constructor: (@orgid, @userid) ->

  create: (agent) ->
    agent
    .post(@urlFor("/#{@orgid}/leaders"))
    .withCredentials()
    .send {user: @userid}

  onSuccess: (result, publish) ->
    org = new Org(result.org)
    publish new OrgChangedEvent(org)

module.exports = AddLeaderToOrgRequest
