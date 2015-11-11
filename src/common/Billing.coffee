if TASKTORCH_FLAGS_DEBUG
  STRIPE_PUBLISHABLE_KEY = 'pk_test_VG9jcQJmyHMZE9ScaPm6YxLv'
else
  STRIPE_PUBLISHABLE_KEY = 'pk_live_s3ToHBiAnQgRSG09TKCvNbm9'

Stripe.setPublishableKey(STRIPE_PUBLISHABLE_KEY)

Billing = {}

Billing.getCardBrand = (number) ->
  Stripe.card.cardType(number)

Billing.validateNumber = (number) ->
  Stripe.card.validateCardNumber(number)

Billing.validateExpiry = (expiry) ->
  Stripe.card.validateExpiry(expiry)

Billing.validateCVC = (cvc) ->
  Stripe.card.validateCVC(cvc)

Billing.getCardToken = (data, callback) ->
  Stripe.card.createToken {
    number:          data.number
    cvc:             data.cvc
    exp:             data.expiry
    # address_line1:   data.address.line1
    # address_line2:   data.address.line2
    # address_city:    data.address.city
    # address_state:   data.address.state
    # address_zip:     data.address.zip
    # address_country: data.address.country
  }, (status, response) ->
    if status isnt 200
      callback(response)
    else
      callback(null, response.id)

module.exports = Billing
