_     = require 'lodash'
Store = require 'framework/Store'

class StackStore extends Store

  constructor: ->
    @stacks = {}

  getStack: (id) ->
    @stacks[id]

  getAllStacks: ->
    _.values(@stacks)

  getStacksByOwner: (userId) ->
    _.filter @stacks, (stack) -> stack.owner? and stack.owner == userId

  getStacksByTeam: (teamId) ->
    _.filter @stacks, (stack) -> stack.team? and stack.team == teamId

  onStacksLoaded: (event) ->
    @stacks = _.extend @stacks, _.indexBy(event.stacks, 'id')
    @announce()

module.exports = StackStore
