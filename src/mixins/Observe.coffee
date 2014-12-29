_     = require 'lodash'
React = require 'react'

NO_OP = (->)

Observe = (storesToWatch...) -> {

  componentWillMount: ->
    _.each storesToWatch, (name) =>
      EventBus.getStore(name).on('change', @_updateState)

  componentWillUnmount: ->
    _.each storesToWatch, (name) =>
      EventBus.getStore(name).removeListener('change', @_updateState)

  componentWillReceiveProps: (newProps) ->
    @_updateState() if storesToWatch.length > 0

  getInitialState: ->
    if storesToWatch.length == 0
      return null
    else
      return @_getUpdatedStateFromStores()

  publish: (event) ->
    EventBus.publish(event)
    
  # TODO: This depends on two globals (AppContext and EventBus).
  # We need to find a better way to glue things together.
  execute: (request, callback = NO_OP) ->
    console.warn "WARNING: #{@constructor.displayName} still calling execute() like a doofus"
    request.execute(AppContext, EventBus, callback)

  renderChildrenIfReady: -> # TODO: Rename
    ready = @ready()
    missing = _.filter _.keys(ready), (key) -> !ready[key]
    if missing.length == 0
      return @children()
    else
      console.debug "[#{@constructor.displayName}] Can't render due to missing state: #{missing.join(', ')}"
      return []

  _updateState: ->
    @setState(@_getUpdatedStateFromStores()) if @isMounted()

  _getUpdatedStateFromStores: ->
    stores = EventBus.getStores(storesToWatch)
    return @sync(stores)

}

module.exports = Observe
