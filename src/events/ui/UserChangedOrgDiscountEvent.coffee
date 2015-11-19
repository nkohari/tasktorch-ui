UiEvent = require 'events/framework/UiEvent'

class UserChangedOrgDiscountEvent extends UiEvent

  type: 'UserChangedOrgDiscount'

  constructor: (@orgid, @discount) ->

module.exports = UserChangedOrgDiscountEvent
