#--------------------------------------------------------------------------------
_                       = require 'lodash'
React                   = require 'react'
PropTypes               = require 'ui/framework/PropTypes'
CachedState             = require 'ui/framework/mixins/CachedState'
Button                  = React.createFactory(require 'ui/common/Button')
Dialog                  = React.createFactory(require 'ui/common/Dialog')
DialogFooter            = React.createFactory(require 'ui/common/DialogFooter')
DialogTrigger           = React.createFactory(require 'ui/common/DialogTrigger')
AccountBillingPeriod    = React.createFactory(require 'ui/dialogs/manageAccount/AccountBillingPeriod')
AccountCreditCard       = React.createFactory(require 'ui/dialogs/manageAccount/AccountCreditCard')
AccountSubscriptionMath = React.createFactory(require 'ui/dialogs/manageAccount/AccountSubscriptionMath')
{div}                   = React.DOM
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

    footer = DialogFooter {
      left: DialogTrigger {name: 'OrgMembers', orgid: @props.orgid},
        Button {icon: 'org', text: 'Manage members'}
      right: Button {text: 'Done', onClick: @props.closeDialog}
    }

    Dialog {icon: 'billing', title: "Account details for #{@state.org?.name}", footer, closeDialog: @props.closeDialog},
      AccountCreditCard {org: @state.org}
      AccountBillingPeriod {org: @state.org}
      AccountSubscriptionMath {org: @state.org}

}

module.exports = ManageAccountDialog
