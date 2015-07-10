#--------------------------------------------------------------------------------
_                = require 'lodash'
React            = require 'react'
StackType        = require 'data/enums/StackType'
PropTypes        = require 'ui/framework/PropTypes'
Pure             = require 'ui/framework/mixins/Pure'
Icon             = React.createFactory(require 'ui/common/Icon')
OverlayTrigger   = React.createFactory(require 'ui/common/OverlayTrigger')
PanelHeader      = React.createFactory(require 'ui/common/PanelHeader')
StackName        = React.createFactory(require 'ui/common/StackName')
StackContextMenu = React.createFactory(require 'ui/screens/workspace/panels/stack/StackContextMenu')
{div}            = React.DOM
#--------------------------------------------------------------------------------

StackHeader = React.createClass {

  displayName: 'StackHeader'

  propTypes:
    stack:   PropTypes.Stack
    panelid: PropTypes.string

  mixins: [Pure]

  render: ->

    if @props.stack?.type is StackType.Backlog
      menu = StackContextMenu {stack: @props.stack}
      controls = OverlayTrigger {overlay: menu},
        Icon {name: 'trigger'}

    PanelHeader {panelid: @props.panelid, icon: @props.stack?.type.toLowerCase(), controls},
      StackName {stack: @props.stack}

}

module.exports = StackHeader
