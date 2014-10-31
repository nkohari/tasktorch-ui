_          = require 'lodash'
request    = require 'superagent'
arrayEnum  = require '../util/arrayEnum'
etag       = require '../util/etag'
Controller = require '../framework/Controller'
Header     = require '../Header'

CardBodyChangedEvent = require './events/CardBodyChangedEvent'
CardsLoadedEvent = require './events/CardsLoadedEvent'
CardTitleChangedEvent = require './events/CardTitleChangedEvent'
JoinedPresenceChannelEvent = require './events/JoinedPresenceChannelEvent'
StacksLoadedEvent = require './events/StacksLoadedEvent'
UserConnectedEvent = require './events/UserConnectedEvent'
UserDisconnectedEvent = require './events/UserDisconnectedEvent'
WorkspaceLoadedEvent = require './events/WorkspaceLoadedEvent'

class WorkspaceController extends Controller

  constructor: (stores, listeners) ->
    super(stores, listeners)
    @pusher = new Pusher '9bc5b19ceaf8c59adcea',
      authEndpoint: '/api/_auth/presence'
      encrypted: true

  setOrganization: (organizationId) ->
    @organizationId = organizationId

  joinPresenceChannel: ->
    channel = @pusher.subscribe("presence-#{@organizationId}")
    channel.bind 'pusher:subscription_succeeded', (channelState) =>
      connectedUsers = _.map channelState.members, (member) -> member
      @dispatch new JoinedPresenceChannelEvent(connectedUsers)
    channel.bind 'pusher:member_added', (member) =>
      @dispatch new UserConnectedEvent(member.info)
    channel.bind 'pusher:member_removed', (member) =>
      @dispatch new UserDisconnectedEvent(member.info)
    @bindListeners(channel)

  leavePresenceChannel: ->
    @pusher.unsubscribe("presence-#{@organizationId}")

  loadWorkspace: ->
    request.get "/api/#{@organizationId}/my/workspace", (res) =>
      @dispatch new WorkspaceLoadedEvent(res.body)

  loadStack: (stackId) ->
    request.get "/api/#{@organizationId}/stacks/#{stackId}", (res) =>
      @dispatch new StacksLoadedEvent([res.body])

  loadCardsInStack: (stackId) ->
    request.get "/api/#{@organizationId}/stacks/#{stackId}/cards", (res) =>
      @dispatch new CardsLoadedEvent(res.body)

  loadCard: (cardId) ->
    request.get "/api/#{@organizationId}/cards/#{cardId}", (res) =>
      @dispatch new CardsLoadedEvent([res.body])

  setCardTitle: (card, title) ->
    request.put("#{card.uri}/title")
    .set(Header.IfMatch, etag.encode(card.version))
    .set(Header.Socket, @pusher.connection.socket_id)
    .send {title}
    .end (res) =>
      version = etag.decode(res.header['etag'])
      @dispatch new CardTitleChangedEvent(card.id, title, version)

  setCardBody: (card, body) ->
    request.put("#{card.uri}/body")
    .set(Header.IfMatch, card.version)
    .set(Header.Socket, @pusher.connection.socket_id)
    .send {body}
    .end (res) =>
      version = etag.decode(res.header['etag'])
      @dispatch new CardBodyChangedEvent(card.id, body, version)

module.exports = WorkspaceController
