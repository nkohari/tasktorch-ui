_                   = require 'lodash'
SingletonListStore  = require 'data/framework/SingletonListStore'
LoadMyStacksRequest = require 'data/requests/LoadMyStacksRequest'

class MyStacksStore extends SingletonListStore

  displayName: 'MyStacksStore'
  name:        'myStacks'
  dependsOn:   'stacks'

  listensFor: [
    'MyStacksLoaded'
  ]

  load: ->
    @execute new LoadMyStacksRequest()

  onMyStacksLoaded: (event) ->
    @set(_.pluck(event.stacks, 'id'))

module.exports = MyStacksStore
