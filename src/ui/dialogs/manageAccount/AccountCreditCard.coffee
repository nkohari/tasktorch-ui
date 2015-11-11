#--------------------------------------------------------------------------------
_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
Button         = React.createFactory(require 'ui/common/Button')
DialogTrigger  = React.createFactory(require 'ui/common/DialogTrigger')
{div, em, img} = React.DOM
#--------------------------------------------------------------------------------
require './AccountCreditCard.styl'
#--------------------------------------------------------------------------------

AccountCreditCard = React.createClass {

  displayName: 'AccountCreditCard'

  props:
    org: PropTypes.Org

  render: ->

    source = @props.org?.account?.source
    if not source?
      return @renderMissing()

    div {className: 'account-credit-card'},
      @renderBrandImage(source)
      div {className: 'account-credit-card-info'},
        div {className: 'account-credit-card-last4'},
          "Ending in "
          em {}, source.last4
        div {className: 'account-credit-card-expiry'},
          "Expires "
          em {}, "#{source.month}/#{source.year}"
      div {className: 'account-credit-card-button'},
        DialogTrigger {name: 'ChangeOrgCreditCard', orgid: @props.orgid},
          Button {icon: 'billing', text: 'Change card'}

  renderBrandImage: (source) ->

    switch source.brand
      when 'Visa'            then src = require('img/cc-visa.svg')
      when 'MasterCard'      then src = require('img/cc-mastercard.svg')
      when 'AmericanExpress' then src = require('img/cc-amex.svg')
      else
        src = require('img/cc-other.svg')

    img {className: 'account-credit-card-brand', src}

}

module.exports = AccountCreditCard
