superagent      = require 'superagent'
Request         = require 'framework/Request'
OrgsLoadedEvent = require 'events/load/OrgsLoadedEvent'

class LoadMyOrgsRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/me/orgs", (res) =>
      {orgs} = res.body
      eventBus.publish new OrgsLoadedEvent(orgs)

module.exports = LoadMyOrgsRequest
