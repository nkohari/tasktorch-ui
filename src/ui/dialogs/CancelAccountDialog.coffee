#--------------------------------------------------------------------------------
React                     = require 'react'
UserCancelledAccountEvent = require 'events/ui/UserCancelledAccountEvent'
PropTypes                 = require 'ui/framework/PropTypes'
Actor                     = require 'ui/framework/mixins/Actor'
IdentityContext           = require 'ui/framework/mixins/IdentityContext'
Button                    = React.createFactory(require 'ui/common/Button')
Dialog                    = React.createFactory(require 'ui/common/Dialog')
DialogFooter              = React.createFactory(require 'ui/common/DialogFooter')
Field                     = React.createFactory(require 'ui/common/Field')
TextArea                  = React.createFactory(require 'ui/common/TextArea')
{div, p, em}              = React.DOM
#--------------------------------------------------------------------------------

CancelAccountDialog = React.createClass {

  displayName: 'CancelAccountDialog'

  mixins: [Actor, IdentityContext]

  getInitialState: ->
    {reason: ''}

  componentDidMount: ->
    @refs.reason.focus()

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: "Yes, cancel my account", className: 'warning', onClick: @cancelAccount}
        Button {text: 'Cancel',                 onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'org', className: 'cancel-account-dialog', title: "Cancel Account for #{@getCurrentOrg().name}", footer, closeDialog: @props.closeDialog},
      p {className: 'warning-prompt'},
        "WARNING: THIS CANNOT BE UNDONE!"
      p {},
        "If you choose to cancel your account, your organization will remain active until the "
        "end of your next billing cycle, after which your data will be removed from our system."
      Field {label: 'Why are you leaving? (optional)'},
        TextArea {ref: 'reason', rows: 5, onChange: @setReason}

  setReason: (event) ->
    @setState {reason: event.target.value}

  cancelAccount: ->
    @publish new UserCancelledAccountEvent(@getCurrentOrg().id, @state.reason)
    @props.closeDialog()

}

module.exports = CancelAccountDialog
