Listener          = require 'framework/Listener'
CardChangedEvent  = require 'events/CardChangedEvent'
StackChangedEvent = require 'events/StackChangedEvent'

class DocumentChangedListener extends Listener

  listensFor: 'Changed'

  createEvent: (message) ->
    switch message.type
      when 'Card'  then return new CardChangedEvent(message.document)
      when 'Stack' then return new StackChangedEvent(message.document)
      else return null

module.exports = DocumentChangedListener
