DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class InvoicesByOrgLoadedEvent extends DataLoadedEvent

  type: 'InvoicesByOrgLoaded'

  constructor: (@orgid, @invoices) ->

module.exports = InvoicesByOrgLoadedEvent
