#--------------------------------------------------------------------------------
React                       = require 'react'
UserReactivatedAccountEvent = require 'events/ui/UserReactivatedAccountEvent'
PropTypes                   = require 'ui/framework/PropTypes'
Actor                       = require 'ui/framework/mixins/Actor'
IdentityContext             = require 'ui/framework/mixins/IdentityContext'
Button                      = React.createFactory(require 'ui/common/Button')
Dialog                      = React.createFactory(require 'ui/common/Dialog')
DialogFooter                = React.createFactory(require 'ui/common/DialogFooter')
Field                       = React.createFactory(require 'ui/common/Field')
TextArea                    = React.createFactory(require 'ui/common/TextArea')
{p}                         = React.DOM
#--------------------------------------------------------------------------------

ReactivateAccountDialog = React.createClass {

  displayName: 'ReactivateAccountDialog'

  mixins: [Actor, IdentityContext]

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: "Yes, reactivate my account", onClick: @reactivateAccount}
        Button {text: 'Cancel',                     onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'org', className: 'reactivate-account-dialog', title: "Reactivate Account for #{@getCurrentOrg().name}", footer, closeDialog: @props.closeDialog},
      p {},
        "Thanks for giving us another try! If you reactivate your account, your subscription "
        "will no longer be cancelled at the end of this billing cycle, and you will be invoiced "
        "on the same billing cycle going forward."

  reactivateAccount: ->
    @publish new UserReactivatedAccountEvent(@getCurrentOrg().id)
    @props.closeDialog()

}

module.exports = ReactivateAccountDialog
