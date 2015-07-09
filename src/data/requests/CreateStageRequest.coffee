superagent        = require 'superagent'
Stage             = require 'data/models/Stage'
StageCreatedEvent = require 'events/create/StageCreatedEvent'
Request           = require 'data/framework/Request'

class CreateStageRequest extends Request

  constructor: (@kindid, @name, @position) ->

  execute: (eventQueue) ->
    superagent.post(@urlFor("/#{Environment.orgid}/kinds/#{@kindid}/stages"))
    .withCredentials()
    .send {@name, @position}
    .end (err, res) =>
      team = new Stage(res.body.team)
      eventQueue.publish new StageCreatedEvent(team)

module.exports = CreateStageRequest
