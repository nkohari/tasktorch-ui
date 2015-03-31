_                    = require 'lodash'
React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
ContextMenu          = React.createFactory(require 'ui/common/ContextMenu')
ContextMenuSeparator = React.createFactory(require 'ui/common/ContextMenuSeparator')
DialogTrigger        = React.createFactory(require 'ui/common/DialogTrigger')
Icon                 = React.createFactory(require 'ui/common/Icon')
{div}                = React.DOM

TeamContextMenu = React.createClass {

  displayName: 'TeamContextMenu'

  propTypes:
    team:        PropTypes.Team
    hideOverlay: PropTypes.func

  render: ->

    ContextMenu {hideOverlay: @props.hideOverlay},
      DialogTrigger {name: 'RenameTeam', team: @props.team},
        Icon {name: 'edit'}
        'Rename this team'
      DialogTrigger {name: 'TeamMembers', team: @props.team},
        Icon {name: 'user'}
        'Manage membership'
      DialogTrigger {name: 'CreateStack', team: @props.team},
        Icon {name: 'stack-backlog'}
        'Create a new stack'
      ContextMenuSeparator {}
      DialogTrigger {name: 'DeleteTeam', team: @props.team},
        Icon {name: 'trash'}
        'Delete this team'
}

module.exports = TeamContextMenu
