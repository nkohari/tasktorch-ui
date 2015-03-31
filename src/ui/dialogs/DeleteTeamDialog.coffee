React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
UserDeletedTeamEvent = require 'events/ui/UserDeletedTeamEvent'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogButtons        = React.createFactory(require 'ui/common/DialogButtons')
{div}                = React.DOM

DeleteTeamDialog = React.createClass {

  displayName: 'DeleteTeamDialog'

  propTypes:
    team:        PropTypes.Team
    closeDialog: PropTypes.func

  mixins: [Actor]

  render: ->

    Dialog {icon: 'trash', title: "Delete #{@props.team.name}", @closeDialog},
      'Are you sure you want to delete this team? This action cannot be undone!'
      DialogButtons {},
        Button {text: 'Delete Team', className: 'warning', onClick: @deleteTeam}
        Button {text: 'Cancel', onClick: @props.closeDialog}    

  deleteTeam: ->
    @publish new UserDeletedTeamEvent(@props.team.id)
    @props.closeDialog()

}

module.exports = DeleteTeamDialog
