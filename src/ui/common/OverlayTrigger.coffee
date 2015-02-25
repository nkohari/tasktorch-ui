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
    {expanded: false}

  componentDidMount: ->
    document.addEventListener('mousedown', @onDocumentClicked)
    Keymaster('esc', @onEscapePressed)

  componentWillUnmount: ->
    document.removeEventListener('mousedown', @onDocumentClicked)
    Keymaster.unbind('esc', @onEscapePressed)

  render: ->

    props = mergeProps _.omit(@props, 'overlay'), {
      className: classSet [
        'expanded' if @state.expanded
      ]
    }

    child = React.Children.only(@props.children)
    trigger = cloneWithProps child, {
      className: classSet [
        'active' if @state.expanded
      ]
      onClick: @toggleOverlay
    }

    if @state.expanded
      overlay = cloneWithProps @props.overlay, {hide: @hideOverlay}

    div props,
      trigger
      CSSTransitionGroup {component: 'div', transitionName: 'slide'},
        overlay

  showOverlay: ->
    @setState {expanded: true}

  hideOverlay: ->
    @setState {expanded: false}

  toggleOverlay: ->
    @setState {expanded: !@state.expanded}

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
