#--------------------------------------------------------------------------------
_                         = require 'lodash'
React                     = require 'react'
AccountSubscriptionStatus = require 'data/enums/AccountSubscriptionStatus'
PropTypes                 = require 'ui/framework/PropTypes'
Time                      = React.createFactory(require 'ui/common/Time')
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

    div {className: 'account-billing-period'},
      div {className: 'row'},
        div {className: 'label'}, "Account status"
        div {className: 'value'}, @renderSubscriptionStatus(subscription.status)
      div {className: 'row'},
        div {className: 'label'}, "Current billing period"
        div {className: 'value'},
          Time {time: subscription.periodStart, format: 'M/D/YYYY'}
          span {className: 'divider'}, " \u2014 "
          Time {time: subscription.periodEnd, format: 'M/D/YYYY'}

  renderSubscriptionStatus: (status) ->
    switch status
      when AccountSubscriptionStatus.Trial    then text = 'Trial'
      when AccountSubscriptionStatus.Active   then text = 'Active'
      when AccountSubscriptionStatus.PastDue  then text = 'Past Due'
      when AccountSubscriptionStatus.Canceled then text = 'Canceled'

    span {className: "account-subscription-status #{status.toLowerCase()}"}, text

}

module.exports = AccountBillingPeriod
