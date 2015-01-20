Listener           = require 'framework/Listener'
ActionCreatedEvent = require 'events/create/ActionCreatedEvent'
CardCreatedEvent   = require 'events/create/CardCreatedEvent'
NoteCreatedEvent   = require 'events/create/NoteCreatedEvent'

class DocumentCreatedListener extends Listener

  listensFor: 'Created'

  createEvent: (message) ->
    switch message.type
      when 'Action' then return new ActionCreatedEvent(message.document)
      when 'Card'   then return new CardCreatedEvent(message.document)
      when 'Note'   then return new NoteCreatedEvent(message.document)
      else return null

module.exports = DocumentCreatedListener
