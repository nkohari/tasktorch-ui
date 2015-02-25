EventOrigin = require 'data/enums/EventOrigin'
Event       = require 'events/framework/Event'

class DocumentDeletedEvent extends Event

  constructor: (@origin = EventOrigin.Local) ->

module.exports = DocumentDeletedEvent
