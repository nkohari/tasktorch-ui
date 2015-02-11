_           = require 'lodash'
React       = require 'react/addons'
dom         = require 'util/dom'
{div, span} = React.DOM
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)

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
    @_renderOverlay()
    window.addEventListener('resize', @_updateOverlayPosition)

  componentDidUpdate: ->
    @_renderOverlay()

  componentWillUnmount: ->
    @_unmountOverlay()
    window.removeEventListener('resize', @_updateOverlayPosition)

  render: ->

    props =
      hide: @hideOverlay

    if @props.trigger == 'click'
      props.onClick = @toggleOverlay

    if @props.trigger == 'hover'
      props.onMouseOver = @handleMouseOver
      props.onMouseOut = @handleMouseOut

    React.addons.cloneWithProps(React.Children.only(@props.children), props)

  showOverlay: ->
    @setState {overlayVisible: true}, => @_updateOverlayPosition()

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
    @getDOMNode().offsetParent

  getOverlayDOMNode: ->
    # The overlay content is the only child of the <div> rendered by the CSSTransitionGroup.
    @_overlay.getDOMNode().children[0]

  _updateOverlayPosition: ->
    return unless @state.overlayVisible
    @setState {overlayPosition: @_recalculateOverlayPosition()}

  _renderOverlay: ->
    # Create a div that can act as a container for the overlay, and append
    # it to the trigger's offsetParent. (This will pin the overlay to the correct
    # element in the DOM, even if the user scrolls.)
    unless @_container?
      @_container = document.createElement('div')
      @getContainerDOMNode().appendChild(@_container)

    content = CSSTransitionGroup {
      component: 'div'
      transitionName: @props.transition ? 'slide'
    }, @_getOverlayContent()

    # Render the overlay content into the container.
    @_overlay = React.render(content, @_container)

  _getOverlayContent: ->
    return null unless @state.overlayVisible
    React.addons.cloneWithProps(@props.overlay, {
      placement: @props.placement
      position:  @state.overlayPosition
      hide:      @hideOverlay
    })

  _unmountOverlay: ->
    @_overlay = undefined
    return unless @_container?
    React.unmountComponentAtNode(@_container)
    @getContainerDOMNode().removeChild(@_container)
    @_container = undefined

  _getOffset: ->
    trigger = @getDOMNode()
    offset  = dom.getOffset(trigger)
    return _.extend offset, {
      height: trigger.offsetHeight
      width:  trigger.offsetWidth
    }

  _recalculateOverlayPosition: ->
    offset  = @_getOffset()
    overlay = @getOverlayDOMNode()
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
