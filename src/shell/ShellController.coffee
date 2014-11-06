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

  loadCurrentUser: ->
    request.get "/api/me", (res) =>
      @dispatch new CurrentUserLoadedEvent(res.body)

  loadMyOrganizations: ->
    request.get "/api/me/organizations", (res) =>
      @dispatch new OrganizationsLoadedEvent(res.body)

  loadMyQueue: ->
    request.get "/api/#{@organizationId}/me/queue?expand=cards", (res) =>
      queue = _.omit(res.body, '_related')
      cards = res.body['_related'].cards
      @dispatch new QueueLoadedEvent(queue, cards)

  setCurrentOrganization: (organizationId) ->

    if @organizationId?
      EventBus.unsubscribe("presence-#{@organizationId}")

    @organizationId = organizationId

    channel = EventBus.subscribe("presence-#{@organizationId}")
    channel.bind 'pusher:subscription_succeeded', (channelState) =>
      connectedUsers = _.map channelState.members, (member) -> member
      @dispatch new JoinedPresenceChannelEvent(connectedUsers)
    channel.bind 'pusher:member_added', (member) =>
      @dispatch new UserConnectedEvent(member.info)
    channel.bind 'pusher:member_removed', (member) =>
      @dispatch new UserDisconnectedEvent(member.info)

    @bindListeners(channel)

module.exports = ShellController
