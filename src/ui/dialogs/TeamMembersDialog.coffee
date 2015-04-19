React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
Button        = React.createFactory(require 'ui/common/Button')
Dialog        = React.createFactory(require 'ui/common/Dialog')
DialogButtons = React.createFactory(require 'ui/common/DialogButtons')
{div}         = React.DOM

TeamMembersDialog = React.createClass {

  displayName: 'TeamMembersDialog'

  props:
    team:        PropTypes.Team
    closeDialog: PropTypes.func

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Close', onClick: @props.closeDialog}

    Dialog {icon: 'team', title: "#{@props.team.name} Membership", buttons, closeDialog: @props.closeDialog},
      'Nothing to configure yet',

}

module.exports = TeamMembersDialog
