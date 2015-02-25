_       = require 'lodash'
compare = require 'common/util/compare'

CachedState = {

  getInitialState: ->
    unless _.isFunction(@getCachedState)
      throw new Error("You must implement getCachedState() on #{@constructor.name}")
    @getCachedState(@_getStore)

  componentWillMount: ->
    Environment.cache.addListener('StateChanged', @_syncWithCache)

  componentWillUnmount: ->
    Environment.cache.removeListener('StateChanged', @_syncWithCache)

  forceCacheSync: ->
    @_syncWithCache()

  _getStore: (name) ->
    return Environment.cache.getStore(name)

  _syncWithCache: ->
    if @isMounted()
      newState = @getCachedState(@_getStore)
      if compare.hashes(@state, newState)
        console.debug("#{@constructor.displayName}: Ignoring state change")
        console.debug {@state, newState}
      else
        @setState(newState)
    return

}

module.exports = CachedState
