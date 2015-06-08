Store = require 'data/framework/Store'

class PanelStore extends Store

  displayName: 'PanelStore'
  name:        'panels'

  constructor: (eventQueue, cache) ->
    super(eventQueue, cache)
    @items = {}

  get: (screen) ->
    @items[screen]

  set: (screen, value) ->
    @items[name] = value

  clear: ->
    @items = {}

module.exports = PanelStore
