_          = require 'lodash'
Store      = require 'data/framework/Store'
ReadyState = require 'data/enums/ReadyState'
compare     = require 'common/util/compare'

class SingletonListStore extends Store

  constructor: (eventQueue, cache) ->
    super(eventQueue, cache)
    @modelStore = cache.getStore(@dependsOn)
    @list = undefined
    @state = undefined

  get: ->
    if @list?
      return _.map @list, (id) => @modelStore.get(id)
    else
      if @state != ReadyState.Loading
        console.debug("#{@constructor.name}: Cache miss")
        @state = ReadyState.Loading
        @load()
      return undefined

  set: (list) ->
    if not @list? or not compare.arrays(@list, list)
      @list = list
      @state = ReadyState.Loaded
      @announce()

module.exports = SingletonListStore
