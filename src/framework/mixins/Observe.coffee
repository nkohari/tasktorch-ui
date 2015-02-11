_     = require 'lodash'
React = require 'react'

NO_OP = (->)

Observe = (storesToWatch...) -> {

  componentDidMount: ->
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

  forceSync: ->
    @_updateState()

  _updateState: ->
    @setState(@_getUpdatedStateFromStores()) if @isMounted()

  _getUpdatedStateFromStores: ->
    stores = EventBus.getStores(storesToWatch)
    return @sync(stores)

}

module.exports = Observe
