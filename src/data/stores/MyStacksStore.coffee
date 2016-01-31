_                   = require 'lodash'
SingletonListStore  = require 'data/framework/SingletonListStore'
LoadMyStacksRequest = require 'data/requests/LoadMyStacksRequest'

class MyStacksStore extends SingletonListStore

  displayName: 'MyStacksStore'
  name:        'myStacks'
  dependsOn:   'stacks'

  listensFor: [
    'MyStacksLoaded'
    'StackCreated'
    'StackDeleted'
  ]

  load: ->
    @execute new LoadMyStacksRequest()

  onMyStacksLoaded: (event) ->
    @set(_.map(event.stacks, 'id'))

  onStackCreated: (event) ->
    @clear() unless event.stack.team?
    
  onStackDeleted: (event) ->
    @clear() unless event.stack.team?

module.exports = MyStacksStore
