React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
UserDeletedTeamEvent = require 'events/ui/UserDeletedTeamEvent'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogButtons        = React.createFactory(require 'ui/common/DialogButtons')
Prompt               = React.createFactory(require 'ui/common/Prompt')

DeleteTeamDialog = React.createClass {

  displayName: 'DeleteTeamDialog'

  propTypes:
    teamid:      PropTypes.id
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) -> {
    team: cache('teams').get(@props.teamid)
  }

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Delete Team', onClick: @deleteTeam, className: 'warning'}
      Button {text: 'Cancel',      onClick: @props.closeDialog}

    Dialog {icon: 'trash', title: "Delete #{@state.team?.name}", buttons, closeDialog: @props.closeDialog},
      Prompt {hint: 'delete-team'},
        'Are you sure you want to delete this team?'

  deleteTeam: ->
    @publish new UserDeletedTeamEvent(@props.teamid)
    @props.closeDialog()

}

module.exports = DeleteTeamDialog
