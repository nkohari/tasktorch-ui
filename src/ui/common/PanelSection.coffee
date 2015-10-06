#--------------------------------------------------------------------------------
_                = require 'lodash'
React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
Icon             = React.createFactory(require 'ui/common/Icon')
{div, span}      = React.DOM
{cloneWithProps} = React
#--------------------------------------------------------------------------------
require './PanelSection.styl'
#--------------------------------------------------------------------------------

PanelSection = React.createClass {

  displayName: 'PanelSection'

  propTypes:
    icon:  PropTypes.node
    title: PropTypes.string

  render: ->

    if @props.icon?
      if _.isString(@props.icon)
        icon = Icon {className: 'panel-icon', name: @props.icon}
      else
        icon = cloneWithProps @props.icon, {className: 'panel-icon'}

    div {className: 'panel-section'},
      div {className: 'header'},
        icon
        span {className: 'title'}, @props.title
      @props.children

}

module.exports = PanelSection
