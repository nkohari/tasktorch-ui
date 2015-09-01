_                       = require 'lodash'
Request                 = require 'data/framework/Request'
Stack                   = require 'data/models/Stack'
StacksLoadedEvent       = require 'events/load/StacksLoadedEvent'
StacksByTeamLoadedEvent = require 'events/load/StacksByTeamLoadedEvent'

class LoadStacksByTeamRequest extends Request

  constructor: (@teamid) ->

  create: (agent) ->
    agent
    .get(@urlFor("/#{Environment.orgid}/teams/#{@teamid}/stacks"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    stacks = _.map result.stacks, (data) -> new Stack(data)
    publish new StacksLoadedEvent(stacks)
    publish new StacksByTeamLoadedEvent(@teamid, stacks)

module.exports = LoadStacksByTeamRequest
