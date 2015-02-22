_                = require 'lodash'
React            = require 'react/addons'
PropTypes        = require 'framework/PropTypes'
classSet         = require 'framework/util/classSet'
mergeProps       = require 'framework/util/mergeProps'
Frame            = React.createFactory(require 'ui/common/Frame')
{cloneWithProps} = React.addons
{div}            = React.DOM

OverlayTrigger = React.createClass {

  displayName: 'OverlayTrigger'

  propTypes:
    overlay: PropTypes.node

  getInitialState: ->
    {expanded: false}

  render: ->

    props = mergeProps _.omit(@props, 'overlay'), {
      className: classSet [
        'trigger'
        'expanded' if @state.expanded
      ]
    }

    if @state.expanded
      overlay = cloneWithProps(@props.overlay, {hide: @hideOverlay})

    div props,
      Frame {onClick: @showOverlay}, @props.children
      overlay

  showOverlay: ->
    @setState {expanded: true}

  hideOverlay: ->
    @setState {expanded: false}

}

module.exports = OverlayTrigger
