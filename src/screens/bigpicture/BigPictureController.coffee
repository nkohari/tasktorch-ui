_                = require 'lodash'
request          = require 'superagent'
Controller       = require 'framework/Controller'
CardsLoadedEvent = require 'events/CardsLoadedEvent'
TeamsLoadedEvent = require 'events/TeamsLoadedEvent'
UsersLoadedEvent = require 'events/UsersLoadedEvent'

class BigPictureController extends Controller

  setOrganization: (organizationId) ->
    @organizationId = organizationId

  loadTeams: ->
    request.get "/api/#{@organizationId}/teams", (res) =>
      @dispatch new TeamsLoadedEvent(res.body)

  loadUser: (userId) ->
    request.get "/api/users/#{userId}", (res) =>
      @dispatch new UsersLoadedEvent([res.body])

  loadCardsInStack: (stackId) ->
    request.get "/api/#{@organizationId}/stacks/#{stackId}/cards", (res) =>
      @dispatch new CardsLoadedEvent(res.body)

module.exports = BigPictureController
