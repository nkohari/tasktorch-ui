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
      # TODO: Is this the right behavior for missing items in the list?
      return _.compact _.map list, (id) => @modelStore.get(id)
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
    return

  has: (id) ->
    @lists[id]?

  remove: (id) ->
    @lists[id] = undefined
    @states[id] = undefined if @states[id] == ReadyState.Loaded

  clear: ->
    @lists = {}
    @states = {}

module.exports = ListStore