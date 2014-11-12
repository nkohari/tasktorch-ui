superagent               = require 'superagent'
Request                  = require 'framework/Request'
OrganizationsLoadedEvent = require 'events/OrganizationsLoadedEvent'

class LoadMyOrganizationsRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/me/organizations", (res) =>
      eventBus.publish new OrganizationsLoadedEvent(res.body)

module.exports = LoadMyOrganizationsRequest
