#--------------------------------------------------------------------------------
_                       = require 'lodash'
React                   = require 'react'
MembershipLevel         = require 'data/enums/MembershipLevel'
UserCreatedInvitesEvent = require 'events/ui/UserCreatedInvitesEvent'
PropTypes               = require 'ui/framework/PropTypes'
Actor                   = require 'ui/framework/mixins/Actor'
CachedState             = require 'ui/framework/mixins/CachedState'
IdentityContext         = require 'ui/framework/mixins/IdentityContext'
Button                  = React.createFactory(require 'ui/common/Button')
Dialog                  = React.createFactory(require 'ui/common/Dialog')
DialogFooter            = React.createFactory(require 'ui/common/DialogFooter')
InviteEditor            = React.createFactory(require 'ui/common/InviteEditor')
Field                   = React.createFactory(require 'ui/common/Field')
#--------------------------------------------------------------------------------

SendInvitesDialog = React.createClass {

  displayName: 'SendInvitesDialog'

  props:
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState, IdentityContext]

  getInitialState: ->
    {invites: []}

  getCachedState: (cache) -> 
    {org: @getCurrentOrg()}

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Send Invitations', onClick: @sendInvites, disabled: !@isValid()}
        Button {text: 'Cancel',           onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'invite', title: "Invite Others to #{@state.org?.name}", footer, className: 'send-invites-dialog', closeDialog: @props.closeDialog},
      Field {label: 'Who would you like to invite to join the organization?', hint: 'send-invites'},
        InviteEditor {value: @state.invites, @onChange}

  onChange: (invites) ->
    @setState {invites}

  isValid: ->
    @state.invites.length > 0

  sendInvites: ->

    # TODO: Rather than using a boolean toggle we should just use MembershipLevel itself
    invites = _.map @state.invites, (invite) ->
      {email: invite.email, level: if invite.leader then MembershipLevel.Leader else MembershipLevel.Member}

    @publish new UserCreatedInvitesEvent(@state.org.id, invites)
    @props.closeDialog()

}

module.exports = SendInvitesDialog
