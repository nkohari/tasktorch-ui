Card             = require 'data/models/Card'
Request          = require 'data/framework/Request'
CardsLoadedEvent = require 'events/load/CardsLoadedEvent'

class LoadCardRequest extends Request

  constructor: (@cardid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/cards/#{@cardid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardsLoadedEvent([card])

module.exports = LoadCardRequest
