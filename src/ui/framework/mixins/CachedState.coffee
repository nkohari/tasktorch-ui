_       = require 'lodash'
compare = require 'common/util/compare'

CachedState = {

  getInitialState: ->
    unless _.isFunction(@getCachedState)
      throw new Error("You must implement getCachedState() on #{@constructor.name}")
    @getCachedState(@getStore)

  componentWillMount: ->
    Environment.cache.addListener('StateChanged', @_syncWithCache)

  componentWillUnmount: ->
    Environment.cache.removeListener('StateChanged', @_syncWithCache)

  forceCacheSync: ->
    @_syncWithCache()

  setStateAndSync: (patch) ->
    @setState patch, => @_syncWithCache()

  getStore: (name) ->
    return Environment.cache.getStore(name)

  _syncWithCache: ->
    if @isMounted()
      newState = @getCachedState(@getStore)
      @setState(newState) unless compare.hashes(@state, newState)
    return

}

module.exports = CachedState
