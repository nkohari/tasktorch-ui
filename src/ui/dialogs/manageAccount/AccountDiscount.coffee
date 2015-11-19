#--------------------------------------------------------------------------------
_                       = require 'lodash'
React                   = require 'react'
AccountDiscountDuration = require 'data/enums/AccountDiscountDuration'
PropTypes               = require 'ui/framework/PropTypes'
Button                  = React.createFactory(require 'ui/common/Button')
DialogTrigger           = React.createFactory(require 'ui/common/DialogTrigger')
{div, span, em}         = React.DOM
#--------------------------------------------------------------------------------
require './AccountDiscount.styl'
#--------------------------------------------------------------------------------

AccountDiscount = React.createClass {

  displayName: 'AccountDiscount'

  props:
    org: PropTypes.Org

  render: ->

    if @props.org.account?.discount?
      buttonText = 'Change discount'
    else
      buttonText = 'Redeem a discount'

    div {className: 'account-discount'},
      @renderDescription()
      div {className: 'account-discount-buttons'},
        DialogTrigger {name: 'ChangeOrgDiscount', orgid: @props.org.id},
          Button {text: buttonText}

  renderDescription: ->

    discount = @props.org.account?.discount

    unless discount?
      return div {className: 'account-discount-info'},
        "You don't currently have a discount."

    if discount.duration == AccountDiscountDuration.Repeating
      duration = span {},
        " for "
        em {},
          "#{discount.durationMonths} months"
    else if discount.duration == AccountDiscountDuration.Once
      duration = span {},
        " your next bill"
    else
      duration = span {},
        " your subscription"

    if discount.amountOff?
      amount = span {},
        em {},
          "$"
          (discount.amountOff / 100).toFixed(2)
    else
      amount = span {},
        em {},
          discount.percentOff
          "%"

    div {className: 'account-discount-info'},
      "You're receiving "
      amount
      " off "
      duration

}

module.exports = AccountDiscount
