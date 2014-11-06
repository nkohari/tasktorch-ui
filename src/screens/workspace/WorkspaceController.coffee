_                     = require 'lodash'
request               = require 'superagent'
etag                  = require 'common/util/etag'
Controller            = require 'framework/Controller'
EventBus              = require 'framework/EventBus'
Header                = require 'framework/enums/Header'
CardBodyChangedEvent  = require 'events/CardBodyChangedEvent'
CardsLoadedEvent      = require 'events/CardsLoadedEvent'
CardTitleChangedEvent = require 'events/CardTitleChangedEvent'
StacksLoadedEvent     = require 'events/StacksLoadedEvent'
WorkspaceLoadedEvent  = require 'events/WorkspaceLoadedEvent'

class WorkspaceController extends Controller

  setCurrentOrganization: (organizationId) ->
    if @organizationId?
      EventBus.unsubscribe("presence-#{@organizationId}")
    @organizationId = organizationId
    channel = EventBus.subscribe("presence-#{@organizationId}")
    @bindListeners(channel)

  loadWorkspace: ->
    request.get "/api/#{@organizationId}/me/workspace", (res) =>
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
    .set(Header.Socket, EventBus.connection.socket_id)
    .send {title}
    .end (res) =>
      version = etag.decode(res.header['etag'])
      @dispatch new CardTitleChangedEvent(card.id, title, version)

  setCardBody: (card, body) ->
    request.put("#{card.uri}/body")
    .set(Header.IfMatch, etag.encode(card.version))
    .set(Header.Socket, EventBus.connection.socket_id)
    .send {body}
    .end (res) =>
      version = etag.decode(res.header['etag'])
      @dispatch new CardBodyChangedEvent(card.id, body, version)

module.exports = WorkspaceController
