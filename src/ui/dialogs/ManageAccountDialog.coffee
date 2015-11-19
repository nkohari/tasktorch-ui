#--------------------------------------------------------------------------------
_                         = require 'lodash'
React                     = require 'react'
AccountSubscriptionStatus = require 'data/enums/AccountSubscriptionStatus'
PropTypes                 = require 'ui/framework/PropTypes'
CachedState               = require 'ui/framework/mixins/CachedState'
Button                    = React.createFactory(require 'ui/common/Button')
Dialog                    = React.createFactory(require 'ui/common/Dialog')
DialogFooter              = React.createFactory(require 'ui/common/DialogFooter')
DialogTrigger             = React.createFactory(require 'ui/common/DialogTrigger')
Spinner                   = React.createFactory(require 'ui/common/Spinner')
Tab                       = React.createFactory(require 'ui/common/Tab')
TabBlock                  = React.createFactory(require 'ui/common/TabBlock')
AccountBillingPeriod      = React.createFactory(require 'ui/dialogs/manageAccount/AccountBillingPeriod')
AccountCreditCard         = React.createFactory(require 'ui/dialogs/manageAccount/AccountCreditCard')
AccountDiscount           = React.createFactory(require 'ui/dialogs/manageAccount/AccountDiscount')
AccountEmail              = React.createFactory(require 'ui/dialogs/manageAccount/AccountEmail')
AccountInvoiceList        = React.createFactory(require 'ui/dialogs/manageAccount/AccountInvoiceList')
AccountSubscriptionMath   = React.createFactory(require 'ui/dialogs/manageAccount/AccountSubscriptionMath')
{div, p}                  = React.DOM
#--------------------------------------------------------------------------------
require './ManageAccountDialog.styl'
#--------------------------------------------------------------------------------

ManageAccountDialog = React.createClass {

  displayName: 'ManageAccountDialog'

  props:
    orgid:       PropTypes.id
    closeDialog: PropTypes.func

  mixins: [CachedState]

  getCachedState: (cache) -> {
    org:         cache('orgs').get(@props.orgid)
    memberships: cache('membershipsByOrg').get(@props.orgid)
  }

  render: ->

    if @state.org?.account?.subscription?
      @renderNormal()
    else
      @renderNotReady()

  renderNormal: ->

    status = @state.org?.account?.subscription?.status
    if status == AccountSubscriptionStatus.CancellationPending or status == AccountSubscriptionStatus.Canceled
      leftButton = DialogTrigger {name: 'ReactivateAccount', orgid: @props.orgid},
        Button {text: 'Reactivate account'}
    else
      leftButton = DialogTrigger {name: 'CancelAccount', orgid: @props.orgid},
        Button {className: 'warning', text: 'Cancel account'}

    footer = DialogFooter {
      left:  leftButton
      right: Button {text: 'Close', onClick: @props.closeDialog}
    }

    Dialog {icon: 'billing', className: 'manage-account-dialog', title: "Account Details for #{@state.org?.name}", footer, closeDialog: @props.closeDialog},
      TabBlock {selected: 'subscription'},
        Tab {key: 'subscription', title: 'Subscription'},
          AccountBillingPeriod {org: @state.org}
          AccountCreditCard {org: @state.org}
          AccountEmail {org: @state.org}
          AccountDiscount {org: @state.org}
          AccountSubscriptionMath {org: @state.org}
        Tab {key: 'invoices', title: 'Previous Invoices'},
          AccountInvoiceList {org: @state.org}

  renderNotReady: ->

    footer = DialogFooter {
      right: Button {text: 'Close', onClick: @props.closeDialog}
    }

    Dialog {icon: 'billing', className: 'manage-account-dialog', title: "Account Details for #{@state.org?.name}", footer, closeDialog: @props.closeDialog},
      div {className: 'content'},
        p {},
          Spinner {}
          "Setting up your account..."
        p {},
          "Your account is still being set up in our accounting system. "
          "This only happens the first time you sign up, and typically only takes "
          "a minute or two. Please check back soon to manage your account."

}

module.exports = ManageAccountDialog
