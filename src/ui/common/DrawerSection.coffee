#--------------------------------------------------------------------------------
_              = require 'lodash'
React          = require 'react'
mergeProps     = require 'common/util/mergeProps'
PropTypes      = require 'ui/framework/PropTypes'
Icon           = React.createFactory(require 'ui/common/Icon')
OverlayTrigger = React.createFactory(require 'ui/common/OverlayTrigger')
{div, span}    = React.DOM
#--------------------------------------------------------------------------------
require './DrawerSection.styl'
#--------------------------------------------------------------------------------

DrawerSection = React.createClass {

  displayName: 'DrawerSection'

  propTypes:
    title: PropTypes.string
    menu:  PropTypes.node

  render: ->

    props = mergeProps @props, {
      className: 'drawer-section'
    }

    if @props.menu?
      trigger = OverlayTrigger {className: 'settings', overlay: @props.menu},
        Icon {name: 'trigger'}

    div props,
      div {className: 'header'},
        span {className: 'title'}, @props.title
        trigger
      @props.children

}

module.exports = DrawerSection
