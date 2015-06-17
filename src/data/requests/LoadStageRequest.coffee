superagent        = require 'superagent'
Stage             = require 'data/models/Stage'
Request           = require 'data/framework/Request'
StagesLoadedEvent = require 'events/load/StagesLoadedEvent'

class LoadStageRequest extends Request

  constructor: (@stageid) ->

  execute: (eventQueue) ->
    superagent.get(@urlFor("/#{Environment.orgid}/stages/#{@stageid}"))
    .withCredentials()
    .end (err, res) =>
      stage = new Stage(res.body.stage)
      eventQueue.publish new StagesLoadedEvent([stage])

module.exports = LoadStageRequest
