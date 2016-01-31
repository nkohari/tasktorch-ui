Card             = require 'data/models/Card'
CardChangedEvent = require 'events/change/CardChangedEvent'
Request          = require 'data/framework/Request'

class RemoveFileFromCardRequest extends Request

  constructor: (@cardid, @fileid) ->

  create: (identity, agent) ->
    agent
    .del(@urlFor("/#{identity.orgid}/cards/#{@cardid}/files/#{@fileid}"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    card = new Card(result.card)
    publish new CardChangedEvent(card)

module.exports = RemoveFileFromCardRequest
