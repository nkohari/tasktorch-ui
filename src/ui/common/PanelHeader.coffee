_                = require 'lodash'
React            = require 'react/addons'
PropTypes        = require 'ui/framework/PropTypes'
Icon             = React.createFactory(require 'ui/common/Icon')
OverlayTrigger   = React.createFactory(require 'ui/common/OverlayTrigger')
PanelCloseLink   = React.createFactory(require 'ui/common/PanelCloseLink')
{div}            = React.DOM
{cloneWithProps} = React.addons

PanelHeader = React.createClass {

  displayName: 'PanelHeader'

  propTypes:
    icon:    PropTypes.node
    menu:    PropTypes.node
    panelid: PropTypes.string

  render: ->

    if @props.menu?
      trigger = OverlayTrigger {overlay: @props.menu},
        Icon {name: 'trigger'}

    if _.isString(@props.icon)
      icon = Icon {className: 'panel-icon', name: @props.icon}
    else
      icon = cloneWithProps @props.icon, {className: 'panel-icon'}

    div {className: 'header'},
      icon      
      div {className: 'title'},
        @props.children
      div {className: 'controls'},
        trigger
        PanelCloseLink {id: @props.panelid}

}

module.exports = PanelHeader
