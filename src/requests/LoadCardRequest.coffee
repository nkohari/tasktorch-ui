_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
CardsLoadedEvent = require 'events/load/CardsLoadedEvent'
KindsLoadedEvent = require 'events/load/KindsLoadedEvent'

class LoadCardRequest extends Request

  constructor: (@cardid) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.orgid}/cards/#{@cardid}", (res) =>
      {card} = res.body
      eventBus.publish new CardsLoadedEvent([card])

module.exports = LoadCardRequest
