UiEvent = require 'events/framework/UiEvent'

class UserChangedOrgCreditCardEvent extends UiEvent

  type: 'UserChangedOrgCreditCard'

  constructor: (@orgid, @token) ->

module.exports = UserChangedOrgCreditCardEvent
