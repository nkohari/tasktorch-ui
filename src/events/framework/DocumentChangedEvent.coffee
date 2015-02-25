EventOrigin = require 'data/enums/EventOrigin'
Event       = require 'events/framework/Event'

class DocumentChangedEvent extends Event

  constructor: (@origin = EventOrigin.Local) ->

module.exports = DocumentChangedEvent
