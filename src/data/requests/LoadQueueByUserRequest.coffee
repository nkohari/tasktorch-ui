_                 = require 'lodash'
Request           = require 'data/framework/Request'
Stack             = require 'data/models/Stack'
StacksLoadedEvent = require 'events/load/StacksLoadedEvent'

class LoadQueueByUserRequest extends Request

  constructor: (@userid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/members/#{@userid}/queue"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    stack = new Stack(result.stack)
    publish new StacksLoadedEvent([stack])

module.exports = LoadQueueByUserRequest
