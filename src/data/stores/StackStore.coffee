Stack            = require 'data/models/Stack'
ModelStore       = require 'data/framework/ModelStore'
LoadStackRequest = require 'data/requests/LoadStackRequest'

class StackStore extends ModelStore

  displayName: 'StackStore'
  name:        'stacks'
  modelType:   Stack

  listensFor: [
    'StacksLoaded'
    'StackChanged'
  ]

  load: (id) ->
    @execute new LoadStackRequest(id)

  onStacksLoaded: (event) ->
    @add(event.stacks)

  onStackChanged: (event) ->
    @add(event.stack)

module.exports = StackStore
