_                   = require 'lodash'
Stack               = require 'data/models/Stack'
StacksLoadedEvent   = require 'events/load/StacksLoadedEvent'
MyStacksLoadedEvent = require 'events/load/MyStacksLoadedEvent'
Request             = require 'data/framework/Request'

class LoadMyStacksRequest extends Request

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{identity.orgid}/me/stacks"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    stacks = _.map result.stacks, (doc) -> new Stack(doc)
    publish new StacksLoadedEvent(stacks)
    publish new MyStacksLoadedEvent(stacks)

module.exports = LoadMyStacksRequest
