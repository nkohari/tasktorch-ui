EventOrigin = require 'data/enums/EventOrigin'
Event       = require 'events/framework/Event'

class DocumentCreatedEvent extends Event

  constructor: (@origin = EventOrigin.Local) ->

module.exports = DocumentCreatedEvent
