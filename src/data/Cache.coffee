EventEmitter = require 'eventemitter3'

class Cache extends EventEmitter

  constructor: (@eventQueue) ->
    @stores = {}
    @hasPendingChanges = false
    @eventQueue.addListener('flushed', @onEventQueueFlushed.bind(this))

  getStore: (name) ->
    store = @stores[name]
    unless store?
      throw new Error("No store named #{name} has been registered with the Cache")
    return store

  addStore: (store) ->
    @stores[store.name] = store

  addStores: (stores) ->
    @addStore(store) for store in stores

  announce: (store) ->
    if @eventQueue.isFlushing
      console.debug("Cache: Deferred announcement of changes from #{store.displayName}")
      @hasPendingChanges = true
    else
      @_announceChanges()

  onEventQueueFlushed: ->
    if @hasPendingChanges
      @_announceChanges()
      @hasPendingChanges = false

  _announceChanges: ->
    console.debug("Cache: Announcing changes")
    @emit('StateChanged')

module.exports = Cache
