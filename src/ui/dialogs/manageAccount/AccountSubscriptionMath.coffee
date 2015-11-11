#--------------------------------------------------------------------------------
_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
Time        = React.createFactory(require 'ui/common/Time')
{div, span} = React.DOM
#--------------------------------------------------------------------------------
require './AccountSubscriptionMath.styl'
#--------------------------------------------------------------------------------

AccountSubscriptionMath = React.createClass {

  displayName: 'AccountSubscriptionMath'

  props:
    org: PropTypes.Org

  render: ->

    subscription = @props.org?.account.subscription

    div {className: 'account-subscription-math'},
      div {className: 'row'},
        div {className: 'label'}, "Active organization members"
        div {className: 'value'}, subscription.seats
      div {className: 'row'},
        div {className: 'label'}, "Monthly fee per user"
        div {className: 'value'},
          span {className: 'operator'}, "x"
          "$#{subscription.plan.cost/100}"
      div {className: 'row sum'},
        div {className: 'label'}, "Monthly subscription fee"
        div {className: 'value'}, "$#{subscription.seats * subscription.plan.cost / 100}"

}

module.exports = AccountSubscriptionMath
