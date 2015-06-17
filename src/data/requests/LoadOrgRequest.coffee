superagent      = require 'superagent'
Org             = require 'data/models/Org'
OrgsLoadedEvent = require 'events/load/OrgsLoadedEvent'
Request         = require 'data/framework/Request'

class LoadOrgRequest extends Request

  constructor: (@orgid) ->

  execute: (eventQueue) ->
    superagent.get(@urlFor("/#{@orgid}"))
    .withCredentials()
    .end (err, res) =>
      org = new Org(res.body.org)
      eventQueue.publish new OrgsLoadedEvent([org])

module.exports = LoadOrgRequest
