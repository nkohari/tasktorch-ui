_                 = require 'lodash'
superagent        = require 'superagent'
Request           = require 'framework/Request'
StacksLoadedEvent = require 'events/StacksLoadedEvent'
KindsLoadedEvent  = require 'events/KindsLoadedEvent'
GoalsLoadedEvent  = require 'events/GoalsLoadedEvent'
UsersLoadedEvent  = require 'events/UsersLoadedEvent'
CardsLoadedEvent  = require 'events/CardsLoadedEvent'

class LoadCardRequest extends Request

  constructor: (@cardId) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.organizationId}/cards/#{@cardId}?expand=owner,stack,kind", (res) =>
      {owner, stack, kind} = res.body['_related']
      card = _.omit(res.body, '_related')
      eventBus.publish new UsersLoadedEvent([owner]) if owner?
      eventBus.publish new StacksLoadedEvent([stack])
      eventBus.publish new KindsLoadedEvent([kind])
      eventBus.publish new CardsLoadedEvent([card])

module.exports = LoadCardRequest
