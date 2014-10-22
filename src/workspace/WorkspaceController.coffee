_          = require 'lodash'
request    = require 'superagent'
arrayEnum  = require '../util/arrayEnum'
Controller = require '../framework/Controller'

class WorkspaceController extends Controller

  Events: arrayEnum [
    'CardBodyChanged'
    'CardTitleChanged'
    'CardsLoaded'
    'JoinedPresenceChannel'
    'StacksLoaded'
    'WorkspaceLoaded'
    'UserConnected'
    'UserDisconnected'
  ]

  constructor: (@stores) ->
    @pusher = new Pusher '9bc5b19ceaf8c59adcea',
      authEndpoint: '/api/_auth/presence'
      encrypted: true

  setOrganization: (organizationId) ->
    @organizationId = organizationId

  joinPresenceChannel: ->
    channel = @pusher.subscribe("presence-#{@organizationId}")
    channel.bind 'pusher:subscription_succeeded', (channelState) =>
      event = {success: true, connectedUsers: _.map(channelState.members, (m) -> m)}
      @dispatch(@Events.JoinedPresenceChannel, event)
    channel.bind 'pusher:member_added', (member) =>
      event = {success: true, user: member.info}
      @dispatch(@Events.UserConnected, event)
    channel.bind 'pusher:member_removed', (member) =>
      event = {success: true, user: member.info}
      @dispatch(@Events.UserDisconnected, event)

  leavePresenceChannel: ->
    @pusher.unsubscribe("presence-#{@organizationId}")

  loadWorkspace: ->
    request.get "/api/#{@organizationId}/my/workspace", (res) =>
      event = {success: true, workspace: res.body}
      @dispatch(@Events.WorkspaceLoaded, event)

  loadStack: (stackId) ->
    request.get "/api/#{@organizationId}/stacks/#{stackId}", (res) =>
      event = {success: true, stacks: [res.body]}
      @dispatch(@Events.StacksLoaded, event)

  loadCardsInStack: (stackId) ->
    request.get "/api/#{@organizationId}/stacks/#{stackId}/cards", (res) =>
      event = {success: true, cards: res.body}
      @dispatch(@Events.CardsLoaded, event)

  loadCard: (cardId) ->
    request.get "/api/#{@organizationId}/cards/#{cardId}?expand=type", (res) =>
      event = {success: true, cards: [res.body]}
      @dispatch(@Events.CardsLoaded, event)

  setCardTitle: (card, title) ->
    request.post("#{card.uri}/title").send({title}).end (res) =>
      event = {success: true, cardId: card.id, title: title}
      @dispatch(@Events.CardTitleChanged, event)

  setCardBody: (card, body) ->
    request.post("#{card.uri}/body").send({body}).end (res) =>
      event = {success: true, cardId: card.id, body: body}
      @dispatch(@Events.CardBodyChanged, event)

module.exports = WorkspaceController
