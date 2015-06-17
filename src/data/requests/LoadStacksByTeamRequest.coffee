_                       = require 'lodash'
superagent              = require 'superagent'
Request                 = require 'data/framework/Request'
Stack                   = require 'data/models/Stack'
StacksLoadedEvent       = require 'events/load/StacksLoadedEvent'
StacksByTeamLoadedEvent = require 'events/load/StacksByTeamLoadedEvent'

class LoadStacksByTeamRequest extends Request

  constructor: (@teamid) ->

  execute: (eventQueue) ->
    superagent.get(@urlFor("/#{Environment.orgid}/teams/#{@teamid}/stacks"))
    .withCredentials()
    .end (err, res) =>
      stacks = _.map res.body.stacks, (data) -> new Stack(data)
      eventQueue.publish new StacksLoadedEvent(stacks)
      eventQueue.publish new StacksByTeamLoadedEvent(@teamid, stacks)

module.exports = LoadStacksByTeamRequest
