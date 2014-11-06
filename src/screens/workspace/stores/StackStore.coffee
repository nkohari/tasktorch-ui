_     = require 'lodash'
Store = require 'framework/Store'

class StackStore extends Store

  constructor: ->
    @stacks = {}

  getStack: (id) ->
    @stacks[id]

  getAllStacks: ->
    _.values(@stacks)

  onStacksLoaded: (event) ->
    @stacks = _.extend @stacks, _.indexBy(event.stacks, 'id')
    @announce()

  onWorkspaceLoaded: (event) ->
    @stacks = _.indexBy(event.workspace.stacks, 'id')
    @announce()

module.exports = StackStore
