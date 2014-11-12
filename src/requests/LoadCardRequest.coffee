_                 = require 'lodash'
superagent        = require 'superagent'
Request           = require 'framework/Request'
StacksLoadedEvent = require 'events/StacksLoadedEvent'
TypesLoadedEvent  = require 'events/TypesLoadedEvent'
GoalsLoadedEvent  = require 'events/GoalsLoadedEvent'
UsersLoadedEvent  = require 'events/UsersLoadedEvent'
CardsLoadedEvent  = require 'events/CardsLoadedEvent'

class LoadCardRequest extends Request

  constructor: (@cardId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/cards/#{@cardId}?expand=stack,type", (res) =>
      {stack, type} = res.body['_related']
      card = _.omit(res.body, '_related')
      eventBus.publish new StacksLoadedEvent([stack])
      eventBus.publish new TypesLoadedEvent([type])
      eventBus.publish new CardsLoadedEvent([card])

module.exports = LoadCardRequest
