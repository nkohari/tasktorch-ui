Org             = require 'data/models/Org'
Request         = require 'data/framework/Request'
OrgChangedEvent = require 'events/change/OrgChangedEvent'

class ChangeOrgEmailRequest extends Request

  constructor: (@orgid, @email) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{@orgid}/email"))
    .withCredentials()
    .send {@email}

  onSuccess: (result, publish) ->
    org = new Org(result.org)
    publish new OrgChangedEvent(org)

module.exports = ChangeOrgEmailRequest
