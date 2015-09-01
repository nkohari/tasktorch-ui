_                 = require 'lodash'
Org               = require 'data/models/Org'
OrgsLoadedEvent   = require 'events/load/OrgsLoadedEvent'
MyOrgsLoadedEvent = require 'events/load/MyOrgsLoadedEvent'
Request           = require 'data/framework/Request'

class LoadMyOrgsRequest extends Request

  create: (agent) ->
    agent
    .get(@urlFor("/me/orgs"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    orgs = _.map result.orgs, (doc) -> new Org(doc)
    publish new OrgsLoadedEvent(orgs)
    publish new MyOrgsLoadedEvent(orgs)

module.exports = LoadMyOrgsRequest
