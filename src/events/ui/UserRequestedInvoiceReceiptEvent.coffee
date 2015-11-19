UiEvent = require 'events/framework/UiEvent'

class UserRequestedInvoiceReceiptEvent extends UiEvent
  
  type: 'UserRequestedInvoiceReceipt'

  constructor: (@orgid, @invoiceid) ->

module.exports = UserRequestedInvoiceReceiptEvent
