#--------------------------------------------------------------------------------
_                = require 'lodash'
React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
Icon             = React.createFactory(require 'ui/common/Icon')
PanelCloseLink   = React.createFactory(require 'ui/common/PanelCloseLink')
{div}            = React.DOM
{cloneWithProps} = React.addons
#--------------------------------------------------------------------------------
require './PanelHeader.styl'
#--------------------------------------------------------------------------------

PanelHeader = React.createClass {

  displayName: 'PanelHeader'

  propTypes:
    controls: PropTypes.node
    icon:     PropTypes.node
    panelid:  PropTypes.string

  render: ->

    if _.isString(@props.icon)
      icon = Icon {className: 'panel-icon', name: @props.icon}
    else
      icon = cloneWithProps @props.icon, {className: 'panel-icon'}

    div {className: 'header'},
      icon      
      div {className: 'title'},
        @props.children
      div {className: 'controls'},
        @props.controls
        PanelCloseLink {id: @props.panelid}

}

module.exports = PanelHeader
