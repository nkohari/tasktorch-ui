Store = require 'data/framework/Store'

class DialogStore extends Store

  displayName: 'DialogStore'
  name:        'dialogs'

  listensFor: [
    'UserOpenedDialog'
    'UserClosedDialog'
  ]

  constructor: (eventQueue, cache) ->
    super(eventQueue, cache)
    @items = {}

  get: (name) ->
    @items[name]

  set: (name, value) ->
    @items[name] = value
    @announce()

  onUserOpenedDialog: (event) ->
    @set(event.name, event.props)

  onUserClosedDialog: (event) ->
    @set(event.name, undefined)

module.exports = DialogStore
