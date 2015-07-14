#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
ContextMenu          = React.createFactory(require 'ui/common/ContextMenu')
ContextMenuSeparator = React.createFactory(require 'ui/common/ContextMenuSeparator')
DialogTrigger        = React.createFactory(require 'ui/common/DialogTrigger')
Icon                 = React.createFactory(require 'ui/common/Icon')
{div}                = React.DOM
#--------------------------------------------------------------------------------

TeamContextMenu = React.createClass {

  displayName: 'TeamContextMenu'

  propTypes:
    team:        PropTypes.Team
    hideOverlay: PropTypes.func

  render: ->

    ContextMenu {hideOverlay: @props.hideOverlay},
      DialogTrigger {name: 'CreateStack', teamid: @props.team.id},
        Icon {name: 'stack'}
        'Create a stack'
      ContextMenuSeparator {}
      DialogTrigger {name: 'RenameTeam', teamid: @props.team.id},
        Icon {name: 'edit'}
        'Rename this team'
      DialogTrigger {name: 'TeamMembers', teamid: @props.team.id},
        Icon {name: 'team'}
        'Manage members'
      ContextMenuSeparator {}
      DialogTrigger {name: 'DeleteTeam', teamid: @props.team.id},
        Icon {name: 'trash'}
        'Delete this team'
}

module.exports = TeamContextMenu
