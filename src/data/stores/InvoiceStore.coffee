Invoice                   = require 'data/models/Invoice'
ModelStore                = require 'data/framework/ModelStore'
SendInvoiceReceiptRequest = require 'data/requests/SendInvoiceReceiptRequest'

class InvoiceStore extends ModelStore

  displayName: 'InvoiceStore'
  name:        'invoices'
  modelType:   Invoice

  listensFor: [
    'InvoicesLoaded'
    'UserRequestedInvoiceReceipt'
  ]

  load: (id) ->
    debug.warn("InvoiceStore.load() called")

  onInvoicesLoaded: (event) ->
    @add(event.invoices)

  onUserRequestedInvoiceReceipt: (event) ->
    @execute new SendInvoiceReceiptRequest(event.orgid, event.invoiceid)

module.exports = InvoiceStore
