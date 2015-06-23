#--------------------------------------------------------------------------------
_                       = require 'lodash'
React                   = require 'react'
Router                  = require 'react-router'
InviteStatus            = require 'data/enums/InviteStatus'
UserCreatedInvitesEvent = require 'events/ui/UserCreatedInvitesEvent'
PropTypes               = require 'ui/framework/PropTypes'
Actor                   = require 'ui/framework/mixins/Actor'
ShellContext            = require 'ui/framework/mixins/ShellContext'
Button                  = React.createFactory(require 'ui/common/Button')
Field                   = React.createFactory(require 'ui/common/Field')
ModalForm               = React.createFactory(require 'ui/common/ModalForm')
FormButtons             = React.createFactory(require 'ui/common/FormButtons')
InviteEditor            = React.createFactory(require 'ui/common/InviteEditor')
Input                   = React.createFactory(require 'ui/common/Input')
Modal                   = React.createFactory(require 'ui/common/Modal')
ModalMessage            = React.createFactory(require 'ui/common/ModalMessage')
{a, div, p, span}       = React.DOM
#--------------------------------------------------------------------------------

SendInvitesModal = React.createClass {

  displayName: 'SendInvitesModal'

  propTypes:
    url: PropTypes.object

  mixins: [Actor, Router.Navigation, ShellContext]

  getInitialState: -> {
    orgid:   @props.url.params?.orgid
    invites: []
  }

  render: ->

    buttons = FormButtons {},
      Button {type: 'submit', text: 'Send Invitations', disabled: !@isValid(), onClick: @onSubmit}
      span {className: 'divider'}, "\u2014or\u2014"
      a {onClick: @transitionToWorkspace}, "Skip this for now"

    Modal {title: 'Invite Others', className: 'send-invites-modal'},
      div {className: 'modal-form'},
        div {className: 'form-content'},
          Field {label: 'Who would you like to invite to join the organization?'},
            InviteEditor {value: @state.invites, @onChange}
        div {className: 'form-footer'},
          buttons
      ModalMessage {},
        p {},
          "Your organization has been created!"
        p {},
          "Next, you'll probably want to invite your teammates to join the organization. "
          "Enter the email addresses for the people you'd like to invite. "
        p {},
          "They'll receive a message from us with a link that they can use to join your organization. "
          "If they don't already have a TaskTorch account, they'll be able to create one. "
        p {},
          "If you'd rather skip this for now, it's no problem. You can always invite others later."

  onChange: (invites) ->
    @setState {invites}

  isValid: ->
    @state.invites.length > 0

  transitionToWorkspace: ->
    @transitionTo('workspace', {orgid: @state.orgid})

  onSubmit: (event) ->
    @publish new UserCreatedInvitesEvent(@state.orgid, @state.invites)
    @transitionToWorkspace()

}

module.exports = SendInvitesModal
