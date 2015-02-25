_          = require 'lodash'
Store      = require 'data/framework/Store'
ReadyState = require 'data/enums/ReadyState'
compare     = require 'common/util/compare'

class ListStore extends Store

  constructor: (eventQueue, cache) ->
    super(eventQueue, cache)
    @modelStore = cache.getStore(@dependsOn)
    @lists = {}
    @states = {}

  get: (id) ->
    list = @lists[id]
    if list?
      return _.map list, (id) => @modelStore.get(id)
    else
      if @states[id] != ReadyState.Loading
        console.debug("#{@constructor.name}: Cache miss on #{id}")
        @states[id] = ReadyState.Loading
        @load(id)
      return undefined

  set: (id, list) ->
    existing = @lists[id]
    if not existing? or not compare.arrays(existing, list)
      @lists[id] = list
      @states[id] = ReadyState.Loaded
      @announce()

  has: (id) ->
    @lists[id]?

module.exports = ListStore
