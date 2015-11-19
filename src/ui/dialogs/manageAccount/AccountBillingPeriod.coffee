#--------------------------------------------------------------------------------
_                         = require 'lodash'
React                     = require 'react'
AccountSubscriptionStatus = require 'data/enums/AccountSubscriptionStatus'
PropTypes                 = require 'ui/framework/PropTypes'
Time                      = React.createFactory(require 'ui/common/Time')
Spinner                   = React.createFactory(require 'ui/common/Spinner')
{div, span}               = React.DOM
#--------------------------------------------------------------------------------
require './AccountBillingPeriod.styl'
#--------------------------------------------------------------------------------

AccountBillingPeriod = React.createClass {

  displayName: 'AccountBillingPeriod'

  props:
    org: PropTypes.Org

  render: ->

    subscription = @props.org?.account.subscription
    unless subscription?
      div {className: 'account-billing-period'},
        Spinner {size: 16}
        "Subscription updating"

    div {className: "account-billing-period #{subscription.status.toLowerCase()}"},
      div {className: 'row'},
        div {className: 'label'}, "Account status"
        div {className: 'account-subscription-status value'},
          @renderSubscriptionStatus(subscription.status)
      div {className: 'row'},
        div {className: 'label'},
          @renderLabel(subscription.status)
        div {className: 'value'},
          Time {time: subscription.periodEnd, format: 'MMMM DD, YYYY'}

  renderSubscriptionStatus: (status) ->
    switch status
      when AccountSubscriptionStatus.Trial               then 'Trial'
      when AccountSubscriptionStatus.Active              then 'Active'
      when AccountSubscriptionStatus.PastDue             then 'Past Due'
      when AccountSubscriptionStatus.CancellationPending then 'Cancellation Pending'
      when AccountSubscriptionStatus.Canceled            then 'Canceled'

  renderLabel: (status) ->
    switch status
      when AccountSubscriptionStatus.Trial               then 'Trial period ends'
      when AccountSubscriptionStatus.CancellationPending then 'Active until'
      else 'Next invoice date'

}

module.exports = AccountBillingPeriod
