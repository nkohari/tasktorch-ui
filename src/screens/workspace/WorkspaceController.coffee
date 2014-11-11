_                     = require 'lodash'
request               = require 'superagent'
etag                  = require 'common/util/etag'
Controller            = require 'framework/Controller'
EventBus              = require 'framework/EventBus'
Header                = require 'framework/enums/Header'
CardBodyChangedEvent  = require 'events/CardBodyChangedEvent'
CardsLoadedEvent      = require 'events/CardsLoadedEvent'
CardTitleChangedEvent = require 'events/CardTitleChangedEvent'
GoalsLoadedEvent      = require 'events/GoalsLoadedEvent'
StacksLoadedEvent     = require 'events/StacksLoadedEvent'
TypesLoadedEvent      = require 'events/TypesLoadedEvent'
UsersLoadedEvent      = require 'events/UsersLoadedEvent'
WorkspaceLoadedEvent  = require 'events/WorkspaceLoadedEvent'

class WorkspaceController extends Controller

  constructor: (@organizationId, eventBus, stores) ->
    super(eventBus, stores)

  loadWorkspace: ->
    request.get "/api/#{@organizationId}/me/workspace", (res) =>
      @publish new WorkspaceLoadedEvent(res.body)

  loadStack: (stackId) ->
    request.get "/api/#{@organizationId}/stacks/#{stackId}?expand=owner", (res) =>
      {owner} = res.body['_related']
      stack = _.omit(res.body, '_related')
      @publish new UsersLoadedEvent([owner]) if owner?
      @publish new StacksLoadedEvent([stack])

  loadCardsInStack: (stackId) ->
    request.get "/api/#{@organizationId}/stacks/#{stackId}/cards", (res) =>
      @publish new CardsLoadedEvent(res.body)

  loadCard: (cardId) ->
    request.get "/api/#{@organizationId}/cards/#{cardId}?expand=goal,stack,type,participants", (res) =>
      {goal, stack, type, participants} = res.body['_related']
      card = _.omit(res.body, '_related')
      @publish new StacksLoadedEvent([stack])
      @publish new TypesLoadedEvent([type])
      @publish new GoalsLoadedEvent([goal]) if goal?
      @publish new UsersLoadedEvent(participants)
      @publish new CardsLoadedEvent([card])

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
