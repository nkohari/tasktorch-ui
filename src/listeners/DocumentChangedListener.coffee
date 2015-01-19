Listener           = require 'framework/Listener'
ActionChangedEvent = require 'events/change/ActionChangedEvent'
CardChangedEvent   = require 'events/change/CardChangedEvent'
StackChangedEvent  = require 'events/change/StackChangedEvent'

class DocumentChangedListener extends Listener

  listensFor: 'Changed'

  createEvent: (message) ->
    switch message.type
      when 'Action' then return new ActionChangedEvent(message.document)
      when 'Card'   then return new CardChangedEvent(message.document)
      when 'Stack'  then return new StackChangedEvent(message.document)
      else return null

module.exports = DocumentChangedListener
