superagent               = require 'superagent'
Request                  = require 'framework/Request'
OrganizationsLoadedEvent = require 'events/load/OrganizationsLoadedEvent'

class LoadMyOrganizationsRequest extends Request

  execute: (context, eventBus) ->
    superagent.get "/api/me/organizations", (res) =>
      {organizations} = res.body
      eventBus.publish new OrganizationsLoadedEvent(organizations)

module.exports = LoadMyOrganizationsRequest
