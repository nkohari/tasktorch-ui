_                      = require 'lodash'
StackType              = require 'data/enums/StackType'
ModelStore             = require 'data/framework/ModelStore'
LoadQueueByUserRequest = require 'data/requests/LoadQueueByUserRequest'

class QueueByUserStore extends ModelStore

  displayName: 'QueueByUserStore'
  name:        'queueByUser'

  listensFor: [
    'StacksLoaded'
    'StackChanged'
  ]

  load: (userid) ->
    @execute new LoadQueueByUserRequest(userid)

  onStacksLoaded: (event) ->
    for stack in event.stacks
      @set(stack.user, stack) if stack.type == StackType.Queue

  onStackChanged: (event) ->
    {stack} = event
    @set(stack.user, stack) if stack.type == StackType.Queue

module.exports = QueueByUserStore
