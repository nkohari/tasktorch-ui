#--------------------------------------------------------------------------------
_                       = require 'lodash'
React                   = require 'react'
UserCreatedInvitesEvent = require 'events/ui/UserCreatedInvitesEvent'
PropTypes               = require 'ui/framework/PropTypes'
Actor                   = require 'ui/framework/mixins/Actor'
CachedState             = require 'ui/framework/mixins/CachedState'
ShellContext            = require 'ui/framework/mixins/ShellContext'
Button                  = React.createFactory(require 'ui/common/Button')
Dialog                  = React.createFactory(require 'ui/common/Dialog')
DialogButtons           = React.createFactory(require 'ui/common/DialogButtons')
InviteEditor            = React.createFactory(require 'ui/common/InviteEditor')
Field                   = React.createFactory(require 'ui/common/Field')
#--------------------------------------------------------------------------------

SendInvitesDialog = React.createClass {

  displayName: 'SendInvitesDialog'

  props:
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState, ShellContext]

  getInitialState: ->
    {invites: []}

  getCachedState: (cache) -> 
    {org: @getCurrentOrg()}

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Send Invitations', onClick: @sendInvites, disabled: !@isValid()}
      Button {text: 'Cancel',           onClick: @props.closeDialog}

    Dialog {icon: 'invite', title: "Invite Others to #{@state.org?.name}", buttons, className: 'send-invites-dialog', closeDialog: @props.closeDialog},
      Field {label: 'Who would you like to invite to join the organization?', hint: 'send-invites'},
        InviteEditor {value: @state.invites, @onChange}

  onChange: (invites) ->
    @setState {invites}

  isValid: ->
    @state.invites.length > 0

  sendInvites: ->
    @publish new UserCreatedInvitesEvent(@state.org.id, @state.invites)
    @props.closeDialog()

}

module.exports = SendInvitesDialog
