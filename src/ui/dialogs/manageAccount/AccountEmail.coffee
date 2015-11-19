#--------------------------------------------------------------------------------
_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
Button         = React.createFactory(require 'ui/common/Button')
DialogTrigger  = React.createFactory(require 'ui/common/DialogTrigger')
{div, em}      = React.DOM
#--------------------------------------------------------------------------------
require './AccountEmail.styl'
#--------------------------------------------------------------------------------

AccountEmail = React.createClass {

  displayName: 'AccountEmail'

  props:
    org: PropTypes.Org

  render: ->

    div {className: 'account-email'},
      div {className: 'account-email-info'},
        div {className: 'account-email-title'}, "Receipts and billing info will be sent to"
        div {className: 'account-email-value'}, @props.org.email
      div {className: 'account-email-buttons'},
        DialogTrigger {name: 'ChangeOrgEmail', orgid: @props.org.id},
          Button {text: 'Change billing email'}

}

module.exports = AccountEmail
