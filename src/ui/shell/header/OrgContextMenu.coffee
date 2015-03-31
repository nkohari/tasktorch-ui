_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
Button         = React.createFactory(require 'ui/common/Button')
ContextMenu    = React.createFactory(require 'ui/common/ContextMenu')
DialogTrigger  = React.createFactory(require 'ui/common/DialogTrigger')
Icon           = React.createFactory(require 'ui/common/Icon')
OverlayTrigger = React.createFactory(require 'ui/common/OverlayTrigger')

OrgContextMenu = React.createClass {

  displayName: 'OrgContextMenu'

  propTypes:
    currentOrg: PropTypes.Org

  render: ->

    overlay = ContextMenu {position: 'right'},
      DialogTrigger {name: 'CreateTeam', team: @props.team},
        Icon {name: 'team'}
        'Create a team'

    OverlayTrigger {className: 'org menu-button', overlay},
      Button {text: @props.currentOrg.name, caret: true}

}

module.exports = OrgContextMenu
