Org             = require 'data/models/Org'
OrgChangedEvent = require 'events/change/OrgChangedEvent'
Request         = require 'data/framework/Request'

class RemoveMemberFromOrgRequest extends Request

  constructor: (@orgid, @userid) ->

  create: (agent) ->
    agent
    .del(@urlFor("/#{@orgid}/members/#{@userid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    org = new Org(result.org)
    publish new OrgChangedEvent(org)

module.exports = RemoveMemberFromOrgRequest
