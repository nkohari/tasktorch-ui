_                = require 'lodash'
request          = require 'superagent'
Controller       = require 'framework/Controller'
CardsLoadedEvent = require 'events/CardsLoadedEvent'
TeamsLoadedEvent = require 'events/TeamsLoadedEvent'
UsersLoadedEvent = require 'events/UsersLoadedEvent'

class BigPictureController extends Controller

  constructor: (@organizationId, eventBus, stores) ->
    super(eventBus, stores)

  loadTeams: ->
    request.get "/api/#{@organizationId}/teams", (res) =>
      @publish new TeamsLoadedEvent(res.body)

  loadUser: (userId) ->
    request.get "/api/users/#{userId}", (res) =>
      @publish new UsersLoadedEvent([res.body])

  loadCardsInStack: (stackId) ->
    request.get "/api/#{@organizationId}/stacks/#{stackId}/cards", (res) =>
      @publish new CardsLoadedEvent(res.body)

module.exports = BigPictureController
