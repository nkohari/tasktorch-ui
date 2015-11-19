_                        = require 'lodash'
Request                  = require 'data/framework/Request'
Invoice                  = require 'data/models/Invoice'
InvoicesLoadedEvent      = require 'events/load/InvoicesLoadedEvent'
InvoicesByOrgLoadedEvent = require 'events/load/InvoicesByOrgLoadedEvent'

class LoadInvoicesByOrgRequest extends Request

  constructor: (@orgid) ->

  create: (identity, agent) ->
    agent
    .get(@urlFor("/#{@orgid}/account/invoices"))
    .withCredentials()
  
  onSuccess: (result, publish) ->
    invoices = _.map result.invoices, (data) -> new Invoice(data)
    publish new InvoicesLoadedEvent(invoices)
    publish new InvoicesByOrgLoadedEvent(@orgid, invoices)

module.exports = LoadInvoicesByOrgRequest
