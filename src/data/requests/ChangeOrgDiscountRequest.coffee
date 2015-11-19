Org             = require 'data/models/Org'
Request         = require 'data/framework/Request'
OrgChangedEvent = require 'events/change/OrgChangedEvent'

class ChangeOrgDiscountRequest extends Request

  constructor: (@orgid, @discount) ->

  create: (identity, agent) ->
    agent
    .post(@urlFor("/#{@orgid}/discount"))
    .withCredentials()
    .send {@discount}

  onSuccess: (result, publish) ->
    org = new Org(result.org)
    publish new OrgChangedEvent(org)

module.exports = ChangeOrgDiscountRequest
