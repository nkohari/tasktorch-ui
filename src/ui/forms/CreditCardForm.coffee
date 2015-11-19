#--------------------------------------------------------------------------------
forms   = require 'newforms'
Billing = require 'common/Billing'
#--------------------------------------------------------------------------------

CreditCardForm = forms.Form.extend {

  number: forms.CharField
    label: 'Number'
    required: true
    cssClass: 'number'
    widgetAttrs: {autoFocus: true}

  expiry: forms.CharField
    label: 'Expiration (MM/YYYY)'
    cssClass: 'expiry'
    required: true

  cvc: forms.CharField
    label: 'Security Code (CVC)'
    cssClass: 'cvc'
    required: true

  cleanNumber: ->
    {number} = @cleanedData
    unless Billing.validateNumber(number)
      throw forms.ValidationError("Invalid credit card number")

  cleanExpiry: ->
    {expiry} = @cleanedData
    unless Billing.validateExpiry(expiry)
      throw forms.ValidationError("Invalid expiration")

  cleanCVC: ->
    {cvc} = @cleanedData
    unless Billing.validateCVC(cvc)
      throw forms.ValidationError("Invalid CVC")

}

module.exports = CreditCardForm
