_                 = require 'lodash'
superagent        = require 'superagent'
Org               = require 'data/models/Org'
OrgsLoadedEvent   = require 'events/load/OrgsLoadedEvent'
MyOrgsLoadedEvent = require 'events/load/MyOrgsLoadedEvent'
Request           = require 'data/framework/Request'

class LoadMyOrgsRequest extends Request

  execute: (eventQueue) ->
    superagent.get(@urlFor("/me/orgs"))
    .withCredentials()
    .end (err, res) =>
      orgs = _.map res.body.orgs, (doc) -> new Org(doc)
      eventQueue.publish new OrgsLoadedEvent(orgs)
      eventQueue.publish new MyOrgsLoadedEvent(orgs)

module.exports = LoadMyOrgsRequest
