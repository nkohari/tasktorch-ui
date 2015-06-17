superagent       = require 'superagent'
Card             = require 'data/models/Card'
Request          = require 'data/framework/Request'
CardsLoadedEvent = require 'events/load/CardsLoadedEvent'

class LoadCardRequest extends Request

  constructor: (@cardid) ->

  execute: (eventQueue) ->
    superagent.get(@urlFor("/#{Environment.orgid}/cards/#{@cardid}"))
    .withCredentials()
    .end (err, res) =>
      card = new Card(res.body.card)
      eventQueue.publish new CardsLoadedEvent([card])

module.exports = LoadCardRequest
