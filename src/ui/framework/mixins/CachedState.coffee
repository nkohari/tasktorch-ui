_         = require 'lodash'
compare   = require 'common/util/compare'
PropTypes = require 'ui/framework/PropTypes'

CachedState = {

  contextTypes:
    environment: PropTypes.object

  getInitialState: ->
    unless _.isFunction(@getCachedState)
      throw new Error("You must implement getCachedState() on #{@constructor.name}")
    @getCachedState(@getStore)

  componentWillMount: ->
    @_getCache().addListener('StateChanged', @_syncWithCache)

  componentWillUnmount: ->
    @_getCache().removeListener('StateChanged', @_syncWithCache)

  forceCacheSync: ->
    @_syncWithCache()

  setStateAndSync: (patch) ->
    @setState patch, => @_syncWithCache()

  getStore: (name) ->
    return @_getCache().getStore(name)

  _getCache: ->
    @context.environment.get('cache')

  _syncWithCache: ->
    if @isMounted()
      newState = @getCachedState(@getStore)
      @setState(newState) unless compare.hashes(@state, newState)
    return

}

module.exports = CachedState
