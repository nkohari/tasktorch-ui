_                       = require 'lodash'
superagent              = require 'superagent'
Request                 = require 'data/framework/Request'
Card                    = require 'data/models/Card'
CardsLoadedEvent        = require 'events/load/CardsLoadedEvent'
CardsByStackLoadedEvent = require 'events/load/CardsByStackLoadedEvent'

class LoadCardsByStackRequest extends Request

  constructor: (@stackid) ->

  execute: (eventQueue) ->
    superagent.get(@urlFor("/#{Environment.orgid}/stacks/#{@stackid}/cards"))
    .withCredentials()
    .end (err, res) =>
      cards = _.map res.body.cards, (data) -> new Card(data)
      eventQueue.publish new CardsLoadedEvent(cards)
      eventQueue.publish new CardsByStackLoadedEvent(@stackid, cards)

module.exports = LoadCardsByStackRequest
