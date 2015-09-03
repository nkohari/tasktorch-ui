#--------------------------------------------------------------------------------
_          = require 'lodash'
React      = require 'react'
mergeProps = require 'common/util/mergeProps'
PropTypes  = require 'ui/framework/PropTypes'
Link       = React.createFactory(require 'ui/common/Link')
Icon       = React.createFactory(require 'ui/common/Icon')
{span}     = React.DOM
#--------------------------------------------------------------------------------
require './DrawerItem.styl'
#--------------------------------------------------------------------------------

DrawerItem = React.createClass {

  displayName: 'DrawerItem'

  propTypes:
    icon:   PropTypes.string
    label:  PropTypes.string
    badge:  PropTypes.node
    hotkey: PropTypes.string

  render: ->

    props = mergeProps _.omit(@props, 'icon', 'label', 'badge'), {
      className: 'drawer-item'
    }

    if @props.icon?
      if _.isString(@props.icon)
        icon = Icon {name: @props.icon}
      else
        icon = @props.icon

    Link props,
      icon if icon?
      span {className: 'label'}, @props.label
      span {className: 'badge'}, @props.badge if @props.badge?

}

module.exports = DrawerItem
