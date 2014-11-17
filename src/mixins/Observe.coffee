_     = require 'lodash'
React = require 'react'

Observe = (storesToWatch...) -> {

  contextTypes:
    eventBus: React.PropTypes.object
    requestContext: React.PropTypes.object

  childContextTypes:
    eventBus: React.PropTypes.object
    requestContext: React.PropTypes.object

  getChildContext: ->
    return {
      eventBus: @getEventBus()
      requestContext: @getRequestContext()
    }

  componentWillMount: ->
    eventBus = @getEventBus()
    _.each storesToWatch, (name) =>
      eventBus.getStore(name).on('change', @_updateState)

  componentWillUnmount: ->
    eventBus = @getEventBus()
    _.each storesToWatch, (name) =>
      eventBus.getStore(name).removeListener('change', @_updateState)

  getInitialState: ->
    if storesToWatch.length == 0
      return null
    else
      return @_getUpdatedStateFromStores()

  getEventBus: ->
    @props.eventBus ? @context?.eventBus

  getRequestContext: ->
    return @context?.requestContext ? {
      organizationId: @props.params.organizationId
    }

  execute: (request) ->
    requestContext = @getRequestContext()
    eventBus = @getEventBus()
    request.execute(requestContext, eventBus)

  _updateState: ->
    @setState(@_getUpdatedStateFromStores()) if @isMounted()

  _getUpdatedStateFromStores: ->
    try
      stores = @getEventBus().getStores(storesToWatch)
      return @getStateFromStores(stores)
    catch err
      console.error(err)
      throw err

}

module.exports = Observe
