_                = require 'lodash'
Keymaster        = require 'keymaster'
React            = require 'react/addons'
PropTypes        = require 'ui/framework/PropTypes'
classSet         = require 'common/util/classSet'
mergeProps       = require 'common/util/mergeProps'
Frame            = React.createFactory(require 'ui/common/Frame')
{cloneWithProps} = React.addons
{div}            = React.DOM
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)

OverlayTrigger = React.createClass {

  displayName: 'OverlayTrigger'

  propTypes:
    overlay: PropTypes.node

  getInitialState: ->
    {visible: false}

  componentDidMount: ->
    document.addEventListener('mousedown', @onDocumentClicked)
    Keymaster('esc', @onEscapePressed)

  componentWillUnmount: ->
    document.removeEventListener('mousedown', @onDocumentClicked)
    Keymaster.unbind('esc', @onEscapePressed)

  render: ->

    props = mergeProps _.omit(@props, 'overlay'), {
      className: classSet [
        'trigger'
        'active' if @state.visible
      ]
    }

    trigger = cloneWithProps React.Children.only(@props.children), {
      className: classSet [
        'active' if @state.visible
      ]
      onClick: @toggleOverlay
    }

    if @state.visible
      overlay = cloneWithProps @props.overlay, {@hideOverlay}

    div props,
      trigger
      CSSTransitionGroup {component: 'div', transitionName: 'slide'},
        overlay

  showOverlay: ->
    @setState {visible: true}

  hideOverlay: ->
    @setState {visible: false}

  toggleOverlay: ->
    @setState {visible: !@state.visible}

  onEscapePressed: ->
    @hideOverlay() if @isMounted()

  onDocumentClicked: (event) ->
    return unless @isMounted()
    node   = @getDOMNode()
    source = event.target
    while source.parentNode
      return if source is node
      source = source.parentNode
    @hideOverlay()

}

module.exports = OverlayTrigger
