_                = require 'lodash'
superagent       = require 'superagent'
Request          = require 'framework/Request'
CardsLoadedEvent = require 'events/load/CardsLoadedEvent'
KindsLoadedEvent = require 'events/load/KindsLoadedEvent'

class LoadCardRequest extends Request

  constructor: (@cardid) ->

  execute: (context, eventBus) ->
    superagent.get "/api/#{context.orgid}/cards/#{@cardid}?expand=kind", (res) =>
      {card} = res.body
      kinds  = _.values(res.body.related.kinds)
      eventBus.publish new CardsLoadedEvent([card])
      eventBus.publish new KindsLoadedEvent(kinds)

module.exports = LoadCardRequest
