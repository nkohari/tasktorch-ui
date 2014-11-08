_                          = require 'lodash'
request                    = require 'superagent'
EventBus                   = require 'framework/EventBus'
Controller                 = require 'framework/Controller'
CurrentUserLoadedEvent     = require 'events/CurrentUserLoadedEvent'
QueueLoadedEvent           = require 'events/QueueLoadedEvent'
JoinedPresenceChannelEvent = require 'events/JoinedPresenceChannelEvent'
OrganizationsLoadedEvent   = require 'events/OrganizationsLoadedEvent'
UserConnectedEvent         = require 'events/UserConnectedEvent'
UserDisconnectedEvent      = require 'events/UserDisconnectedEvent'

class ShellController extends Controller

  constructor: (@organizationId, eventBus, stores) ->
    super(eventBus, stores)
    @eventBus.subscribe("presence-#{organizationId}")

  loadCurrentUser: ->
    request.get "/api/me", (res) =>
      @publish new CurrentUserLoadedEvent(res.body)

  loadMyOrganizations: ->
    request.get "/api/me/organizations", (res) =>
      @publish new OrganizationsLoadedEvent(res.body)

  loadMyQueue: ->
    request.get "/api/#{@organizationId}/me/queue?expand=cards", (res) =>
      queue = _.omit(res.body, '_related')
      cards = res.body['_related'].cards
      @publish new QueueLoadedEvent(queue, cards)

module.exports = ShellController
