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

  constructor: (@organizationId, eventBus, stores) ->
    super(eventBus, stores)

  loadWorkspace: ->
    request.get "/api/#{@organizationId}/me/workspace", (res) =>
      @publish new WorkspaceLoadedEvent(res.body)

  loadStack: (stackId) ->
    request.get "/api/#{@organizationId}/stacks/#{stackId}", (res) =>
      @publish new StacksLoadedEvent([res.body])

  loadCardsInStack: (stackId) ->
    request.get "/api/#{@organizationId}/stacks/#{stackId}/cards", (res) =>
      @publish new CardsLoadedEvent(res.body)

  loadCard: (cardId) ->
    request.get "/api/#{@organizationId}/cards/#{cardId}", (res) =>
      @publish new CardsLoadedEvent([res.body])

  setCardTitle: (card, title) ->
    request.put("#{card.uri}/title")
    .set(Header.IfMatch, etag.encode(card.version))
    .set(Header.Socket, @eventBus.getSocketId())
    .send {title}
    .end (res) =>
      version = etag.decode(res.header['etag'])
      @publish new CardTitleChangedEvent(card.id, title, version)

  setCardBody: (card, body) ->
    request.put("#{card.uri}/body")
    .set(Header.IfMatch, etag.encode(card.version))
    .set(Header.Socket, @eventBus.getSocketId())
    .send {body}
    .end (res) =>
      version = etag.decode(res.header['etag'])
      @publish new CardBodyChangedEvent(card.id, body, version)

module.exports = WorkspaceController
