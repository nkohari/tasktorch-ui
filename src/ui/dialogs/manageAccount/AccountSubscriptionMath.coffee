#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
Currency           = React.createFactory(require 'ui/common/Currency')
Time               = React.createFactory(require 'ui/common/Time')
{a, div, span, em} = React.DOM
#--------------------------------------------------------------------------------
require './AccountSubscriptionMath.styl'
#--------------------------------------------------------------------------------

AccountSubscriptionMath = React.createClass {

  displayName: 'AccountSubscriptionMath'

  props:
    org: PropTypes.Org

  render: ->

    subscription = @props.org?.account?.subscription
    discount     = @props.org?.account?.discount
    monthlyFee   = subscription.seats * subscription.plan.cost

    rows = [
      div {className: 'row'},
        div {className: 'label'},
          "Organization members"
        div {className: 'value'}, subscription.seats
      div {className: 'row'},
        div {className: 'label'}, "Monthly fee per member"
        div {className: 'value'},
          span {className: 'operator'}, "x"
          Currency {value: subscription.plan.cost}
      div {className: 'row sum'},
        div {className: 'label'}, "Total monthly fee"
        div {className: 'value'},
          Currency {value: monthlyFee}
    ]

    if discount?
      discountAmount = discount.amountOff ? (monthlyFee * (discount.percentOff / 100))
      rows.push [
        div {className: 'row'},
          div {className: 'label'}, "Discount"
          div {className: 'value discount'},
            span {className: 'operator'}, "-"
            Currency {value: discountAmount}
        div {className: 'row sum'},
          div {className: 'label'}, "Discounted monthly fee"
          div {className: 'value'},
            Currency {value: monthlyFee - discountAmount}
      ]

    div {className: 'account-subscription-math'},
      div {className: 'table'},
        rows
      div {className: 'hint'},
        "The number of active members in your organization will be updated nightly, and "
        "changes will result in pro-rated credits or fees applied to your next invoice. "
        "For more information, please see the "
        a {href: 'http://support.tasktorch.com/articles/billingFAQ.html', target: '_blank'}, "Billing FAQ"
        " and "
        a {href: 'http://support.tasktorch.com/articles/billing.html', target: '_blank'}, "Billing Policy"
        " in the TaskTorch Guide."

}

module.exports = AccountSubscriptionMath
