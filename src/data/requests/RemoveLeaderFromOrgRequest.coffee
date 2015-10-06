Org             = require 'data/models/Org'
OrgChangedEvent = require 'events/change/OrgChangedEvent'
Request         = require 'data/framework/Request'

class RemoveLeaderFromOrgRequest extends Request

  constructor: (@orgid, @userid) ->

  create: (identity, agent) ->
    agent
    .del(@urlFor("/#{@orgid}/leaders/#{@userid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    org = new Org(result.org)
    publish new OrgChangedEvent(org)

module.exports = RemoveLeaderFromOrgRequest
