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
      {card} = res.body
      users  = _.values(res.body.related.users)
      stacks = _.values(res.body.related.stacks)
      kinds  = _.values(res.body.related.kinds)
      eventBus.publish new UsersLoadedEvent(users) if users?.length > 0
      eventBus.publish new StacksLoadedEvent(stacks)
      eventBus.publish new KindsLoadedEvent(kinds)
      eventBus.publish new CardsLoadedEvent([card])

module.exports = LoadCardRequest
