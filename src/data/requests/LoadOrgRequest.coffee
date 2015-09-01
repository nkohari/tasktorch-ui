Org             = require 'data/models/Org'
OrgsLoadedEvent = require 'events/load/OrgsLoadedEvent'
Request         = require 'data/framework/Request'

class LoadOrgRequest extends Request

  constructor: (@orgid) ->

  create: (agent) ->
    agent
    .get(@urlFor("/#{@orgid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    org = new Org(result.org)
    publish new OrgsLoadedEvent([org])

module.exports = LoadOrgRequest
