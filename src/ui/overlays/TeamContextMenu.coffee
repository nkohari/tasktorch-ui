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
    teamid:      PropTypes.string
    hideOverlay: PropTypes.func

  render: ->

    ContextMenu {position: 'bottom right', hideOverlay: @props.hideOverlay},
      DialogTrigger {name: 'RenameTeam', teamid: @props.teamid},
        Icon {name: 'edit'}
        'Rename'
      DialogTrigger {name: 'TeamMembers', teamid: @props.teamid},
        Icon {name: 'team'}
        'Team Members'
      ContextMenuSeparator {}
      DialogTrigger {name: 'DeleteTeam', teamid: @props.teamid},
        Icon {name: 'trash'}
        'Delete'
}

module.exports = TeamContextMenu
