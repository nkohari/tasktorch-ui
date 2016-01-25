#--------------------------------------------------------------------------------
React                 = require 'react'
UserOpenedDialogEvent = require 'events/ui/UserOpenedDialogEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
CachedState           = require 'ui/framework/mixins/CachedState'
IdentityContext       = require 'ui/framework/mixins/IdentityContext'
Button                = React.createFactory(require 'ui/common/Button')
Dialog                = React.createFactory(require 'ui/common/Dialog')
DialogFooter          = React.createFactory(require 'ui/common/DialogFooter')
DialogTrigger         = React.createFactory(require 'ui/common/DialogTrigger')
OverlayTrigger        = React.createFactory(require 'ui/common/OverlayTrigger')
TeamListItem          = React.createFactory(require 'ui/dialogs/manageTeams/TeamListItem')
{ul, div}             = React.DOM
#--------------------------------------------------------------------------------
require './ManageTeamsDialog.styl'
#--------------------------------------------------------------------------------

ManageTeamsDialog = React.createClass {

  displayEmail: 'ManageTeamsDialog'

  propTypes:
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState, IdentityContext]

  getCachedState: (cache) -> {
    teams: cache('teamsByOrg').get(@getCurrentOrg().id)
  }

  render: ->

    teams = _.map @state.teams, (team) =>
      TeamListItem {key: team.id, team}

    footer = DialogFooter {
      left:  Button {text: 'Create new team', onClick: @onCreateClicked}
      right: Button {text: 'Close', onClick: @props.closeDialog}
    }

    Dialog {icon: 'team', title: 'Manage Teams', className: 'manage-teams-dialog', width: 400, footer, closeDialog: @props.closeDialog},
      ul {className: 'team-list'},
        teams

  onCreateClicked: ->
    @publish new UserOpenedDialogEvent('CreateTeam')

}

module.exports = ManageTeamsDialog
