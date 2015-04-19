React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
UserDeletedTeamEvent = require 'events/ui/UserDeletedTeamEvent'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogButtons        = React.createFactory(require 'ui/common/DialogButtons')

DeleteTeamDialog = React.createClass {

  displayName: 'DeleteTeamDialog'

  propTypes:
    team:        PropTypes.Team
    closeDialog: PropTypes.func

  mixins: [Actor]

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Delete Team', onClick: @deleteTeam, className: 'warning'}
      Button {text: 'Cancel',      onClick: @props.closeDialog}

    Dialog {icon: 'trash', title: "Delete #{@props.team.name}", buttons, closeDialog: @props.closeDialog},
      'Are you sure you want to delete this team? This action cannot be undone!'

  deleteTeam: ->
    @publish new UserDeletedTeamEvent(@props.team.id)
    @props.closeDialog()

}

module.exports = DeleteTeamDialog
