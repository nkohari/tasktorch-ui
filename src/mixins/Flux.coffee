_     = require 'lodash'
React = require 'react'

ControllerMixin =

  contextTypes:
    controller: React.PropTypes.object

  childContextTypes:
    controller: React.PropTypes.object

  getChildContext: ->
    return {controller: @getController()}

  getController: ->
    @props.controller ? @context?.controller

StoreWatchMixin = (storesToWatch) ->

  return {

    componentWillMount: ->
      controller = @getController()
      _.each storesToWatch, (name) =>
        controller.stores[name].on('change', @_updateState)

    componentWillUnmount: ->
      controller = @getController()
      _.each storesToWatch, (name) =>
        controller.stores[name].removeListener('change', @_updateState)

    getInitialState: ->
      @getStateFromStores(@getController().stores)

    _updateState: ->
      if @isMounted
        newState = @getStateFromStores(@getController().stores)
        @setState(newState)

  }

Flux = (storesToWatch...) ->
  mixin = _.extend {}, ControllerMixin
  mixin = _.extend(mixin, StoreWatchMixin(storesToWatch)) if storesToWatch.length > 0
  return mixin

module.exports = Flux
