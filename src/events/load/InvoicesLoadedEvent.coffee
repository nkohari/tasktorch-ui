DataLoadedEvent = require 'events/framework/DataLoadedEvent'

class InvoicesLoadedEvent extends DataLoadedEvent

  type: 'InvoicesLoaded'

  constructor: (@invoices) ->

module.exports = InvoicesLoadedEvent
