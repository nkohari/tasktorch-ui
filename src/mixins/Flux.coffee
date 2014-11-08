_     = require 'lodash'
React = require 'react'

FluxMixin = (storesToWatch...) -> {

  contextTypes:
    controller: React.PropTypes.object

  childContextTypes:
    controller: React.PropTypes.object

  getChildContext: ->
    return {controller: @getController()}

  componentWillMount: ->
    controller = @getController()
    controller.attachToEventBus() if @_isControllingComponent()
    _.each storesToWatch, (name) =>
      controller.stores[name].on('change', @_updateState)

  componentWillUnmount: ->
    controller = @getController()
    controller.detachFromEventBus() if @_isControllingComponent()
    _.each storesToWatch, (name) =>
      controller.stores[name].removeListener('change', @_updateState)

  getInitialState: ->
    if storesToWatch.length == 0
      return null
    else
      return @_getUpdatedStateFromStores()

  getController: ->
    if @_isControllingComponent()
      @_controller = @createController() unless @_controller?
      return @_controller
    else
      return @context?.controller

  _isControllingComponent: ->
    @createController? and _.isFunction(@createController)

  _updateState: ->
    @setState(@_getUpdatedStateFromStores()) if @isMounted()

  _getUpdatedStateFromStores: ->
    stores = @getController().getStores(storesToWatch)
    @getStateFromStores(stores)

}

module.exports = FluxMixin
