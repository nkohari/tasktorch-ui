#--------------------------------------------------------------------------------
React                    = require 'react'
UserChangedOrgEmailEvent = require 'events/ui/UserChangedOrgEmailEvent'
PropTypes                = require 'ui/framework/PropTypes'
Actor                    = require 'ui/framework/mixins/Actor'
IdentityContext          = require 'ui/framework/mixins/IdentityContext'
Button                   = React.createFactory(require 'ui/common/Button')
Dialog                   = React.createFactory(require 'ui/common/Dialog')
DialogFooter             = React.createFactory(require 'ui/common/DialogFooter')
Field                    = React.createFactory(require 'ui/common/Field')
Input                    = React.createFactory(require 'ui/common/Input')
#--------------------------------------------------------------------------------

ChangeOrgEmailDialog = React.createClass {

  displayName: 'ChangeOrgEmailDialog'

  propTypes:
    closeDialog: PropTypes.func

  mixins: [Actor, IdentityContext]

  getInitialState: ->
    org = @getCurrentOrg()
    {org, email: org.email}

  componentDidMount: ->
    @refs.email.focus()
    @refs.email.select()

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Change Email', className: 'default', disabled: !@isValid(), onClick: @changeEmail}
        Button {text: 'Cancel', onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'settings', title: "Change Billing Email for #{@state.org.name}", footer, closeDialog: @props.closeDialog},
      Field {label: 'Billing/Receipts Email', hint: 'org-email'},
        Input {ref: 'email', icon: 'email', placeholder: 'Enter an email address', value: @state.email, onChange: @onEmailChanged}

  isValid: ->
    @state.email?.length > 0

  onEmailChanged: (event) ->
    @setState {email: event.target.value}

  changeEmail: ->
    @publish new UserChangedOrgEmailEvent(@state.org.id, @state.email)
    @props.closeDialog()

}

module.exports = ChangeOrgEmailDialog
