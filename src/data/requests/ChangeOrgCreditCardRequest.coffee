Org             = require 'data/models/Org'
Request         = require 'data/framework/Request'
OrgChangedEvent = require 'events/change/OrgChangedEvent'

class ChangeOrgCreditCardRequest extends Request

  constructor: (@orgid, @token) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{@orgid}/payment"))
    .withCredentials()
    .send {@token}

  onSuccess: (result, publish) ->
    org = new Org(result.org)
    publish new OrgChangedEvent(org)

module.exports = ChangeOrgCreditCardRequest
