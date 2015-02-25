Stack            = require 'data/models/Stack'
ModelStore       = require 'data/framework/ModelStore'
LoadStackRequest = require 'data/requests/LoadStackRequest'

class StackStore extends ModelStore

  displayName: 'StackStore'
  name:        'stacks'
  modelType:   Stack

  listensFor: [
    'StacksLoaded'
  ]

  load: (id) ->
    @execute new LoadStackRequest(id)

  onStacksLoaded: (event) ->
    @add(event.stacks)

module.exports = StackStore
