_     = require 'lodash'
Store = require 'framework/Store'

class StackStore extends Store

  getAllByOwner: (userId) ->
    _.filter @items, (stack) -> stack.owner? and stack.owner == userId

  getAllByTeam: (teamId) ->
    _.filter @items, (stack) -> stack.team? and stack.team == teamId

  onStacksLoaded: (event) ->
    @add(event.stacks)

  onStackChanged: (event) ->
    @add(event.stack)

module.exports = StackStore
