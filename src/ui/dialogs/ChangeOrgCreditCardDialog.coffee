#--------------------------------------------------------------------------------
_                             = require 'lodash'
React                         = require 'react'
Billing                       = require 'common/Billing'
UserChangedOrgCreditCardEvent = require 'events/ui/UserChangedOrgCreditCardEvent'
CreditCardForm                = require 'ui/forms/CreditCardForm'
PropTypes                     = require 'ui/framework/PropTypes'
Actor                         = require 'ui/framework/mixins/Actor'
IdentityContext               = require 'ui/framework/mixins/IdentityContext'
Button                        = React.createFactory(require 'ui/common/Button')
Dialog                        = React.createFactory(require 'ui/common/Dialog')
DialogFooter                  = React.createFactory(require 'ui/common/DialogFooter')
Form                          = React.createFactory(require 'ui/common/Form')
#--------------------------------------------------------------------------------
require './ChangeOrgCreditCardDialog.styl'
#--------------------------------------------------------------------------------

ChangeOrgCreditCardDialog = React.createClass {

  displayEmail: 'ChangeOrgCreditCardDialog'

  propTypes:
    closeDialog: PropTypes.func

  mixins: [Actor, IdentityContext]

  getInitialState: -> {
    form: new CreditCardForm({@onChange})
  }

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Save Card', onClick: @saveCard}
        Button {text: 'Cancel', onClick: @props.closeDialog}
      ]
    }

    Dialog {className: 'change-org-credit-card-dialog', icon: 'billing', title: "Change credit card for #{@getCurrentOrg().name}", footer, closeDialog: @props.closeDialog},
      Form {form: @state.form}

  onChange: ->
    @forceUpdate()

  saveCard: (event) ->
    event.preventDefault()
    return unless @state.form.validate()
    Billing.getCardToken @state.form.cleanedData, (err, token) =>
      # TODO
      if err?
        alert(err)
        return
      @publish new UserChangedOrgCreditCardEvent(@getCurrentOrg().id, token)
      @props.closeDialog()

}

module.exports = ChangeOrgCreditCardDialog
