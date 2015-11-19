_                        = require 'lodash'
ListStore                = require 'data/framework/ListStore'
LoadInvoicesByOrgRequest = require 'data/requests/LoadInvoicesByOrgRequest'

class InvoicesByOrgStore extends ListStore

  displayName: 'InvoicesByOrgStore'
  name:        'invoicesByOrg'
  dependsOn:   'invoices'

  listensFor: [
    'InvoicesByOrgLoaded'
  ]

  load: (id) ->
    @execute new LoadInvoicesByOrgRequest(id)

  onInvoicesByOrgLoaded: (event) ->
    @set(event.orgid, _.pluck(event.invoices, 'id'))

module.exports = InvoicesByOrgStore
