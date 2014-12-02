_           = require 'lodash'
React       = require 'react/addons'
dom         = require 'common/util/dom'
{div, span} = React.DOM

OverlayTrigger = React.createClass {

  displayName: 'OverlayTrigger'

  getDefaultProps: ->
    return {
      container: {getDOMNode: -> document.body}
    }

  getInitialState: ->
    return {
      overlayVisible: false
      overlayPosition: {top: 0, left: 0}
    }

  componentDidMount: ->
    @_renderLayerAndOverlay()

  componentDidUpdate: ->
    @_renderLayerAndOverlay()

  componentWillUnmount: ->
    @_unmountOverlay()

  render: ->
    props = {}

    if @props.trigger == 'click'
      props.onClick = @toggleOverlay

    if @props.trigger == 'hover'
      props.onMouseOver = @handleMouseOver
      props.onMouseOut = @handleMouseOut

    React.addons.cloneWithProps(React.Children.only(@props.children), props)

  renderOverlay: ->
    unless @state.overlayVisible
      return span {}
    React.addons.cloneWithProps @props.overlay, {
      placement: @props.placement
      position:  @state.overlayPosition
      hide:      @hideOverlay
    }

  showOverlay: ->
    @setState {overlayVisible: true}, =>
      @setState {overlayPosition: @_recalculateOverlayPosition()}

  hideOverlay: ->
    @setState {overlayVisible: false}

  toggleOverlay: ->
    if @state.overlayVisible
      @hideOverlay()
    else
      @showOverlay()

  handleMouseOver: ->
    if @_timeout?
      clearTimeout(@_timeout)
      @_timeout = undefined

    show = () =>
      @_timeout = undefined
      @showOverlay()

    if @props.delay
      @_timeout = setTimeout(show, @props.delay)
    else
      @showOverlay()

  handleMouseOut: ->
    if @_timeout?
      clearTimeout(@_timeout)
      @_timeout = undefined

    hide = () =>
      @_timeout = undefined
      @hideOverlay()

    if @props.delay
      @_timeout = setTimeout(hide, @props.delay)
    else
      @hideOverlay()

  getContainerDOMNode: ->
    if @props.container.getDOMNode?
      @props.container.getDOMNode()
    else
      @props.container

  _renderLayerAndOverlay: ->
    # Create a div that can act as a layer container, and then render the overlay into it.
    unless @_layer?
      @_layer = document.createElement('div')
      @getContainerDOMNode().appendChild(@_layer)
    @_overlay = React.render(@renderOverlay(), @_layer)

  _unmountOverlay: ->
    if @_layer?
      React.unmountComponentAtNode(@_layer)
      @getContainerDOMNode().removeChild(@_layer)
      @_layer = undefined
    @_overlay = undefined

  _getOffset: ->
    trigger = @getDOMNode()
    container = @getContainerDOMNode()

    if container.tagName == 'BODY'
      offset = dom.getOffset(trigger)
    else
      offset = dom.getRelativePosition(trigger, container)

    return _.extend offset, {
      height: trigger.offsetHeight
      width:  trigger.offsetWidth
    }

  _recalculateOverlayPosition: ->
    offset = @_getOffset()
    console.log(offset)
    overlay = @_overlay.getDOMNode()
    console.log {width: overlay.offsetWidth, height: overlay.offsetHeight}
    switch @props.placement
      when 'top'
        return {
          top:  offset.top - overlay.offsetHeight
          left: offset.left + offset.width / 2 - overlay.offsetWidth / 2
        }
      when 'bottom'
        return {
          top:  offset.top + offset.height
          left: offset.left + offset.width / 2 - overlay.offsetWidth / 2
        }
      when 'left'
        return {
          top:  offset.top + offset.height / 2 - overlay.offsetHeight / 2
          left: offset.left - overlay.offsetWidth
        }
      when 'right'
        return {
          top:  offset.top + offset.height / 2 - overlay.offsetHeight / 2
          left: offset.left + offset.width
        }
      else
        throw new Error("Unknown placement #{@props.placement} for OverlayTrigger")

}

module.exports = OverlayTrigger
