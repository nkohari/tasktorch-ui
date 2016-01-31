_     = require 'lodash'
Store = require 'data/framework/Store'

class DialogStore extends Store

  displayName: 'DialogStore'
  name:        'dialogs'

  listensFor: [
    'UserOpenedDialog'
    'UserClosedDialog'
  ]

  constructor: (eventQueue, processor, cache) ->
    super(eventQueue, processor, cache)
    @stack = []

  get: (name) ->
    visible = _.head(@stack)
    if visible?.name == name
      return visible.props
    else
      return undefined

  push: (name, props) ->
    @stack.unshift {name, props}
    @announce()

  pop: ->
    @stack.shift()
    @announce()

  clear: ->
    @stack = []

  onUserOpenedDialog: (event) ->
    @push(event.name, event.props)

  onUserClosedDialog: (event) ->
    @pop()

module.exports = DialogStore
