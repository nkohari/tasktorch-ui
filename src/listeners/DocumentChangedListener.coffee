Listener           = require 'framework/Listener'
ActionChangedEvent = require 'events/change/ActionChangedEvent'
CardChangedEvent   = require 'events/change/CardChangedEvent'
StackChangedEvent  = require 'events/change/StackChangedEvent'
TeamChangedEvent   = require 'events/change/TeamChangedEvent'
UserChangedEvent   = require 'events/change/UserChangedEvent'

class DocumentChangedListener extends Listener

  listensFor: 'Changed'

  createEvent: (message) ->
    switch message.type
      when 'Action' then return new ActionChangedEvent(message.document)
      when 'Card'   then return new CardChangedEvent(message.document)
      when 'Stack'  then return new StackChangedEvent(message.document)
      when 'Team'   then return new TeamChangedEvent(message.document)
      when 'User'   then return new UserChangedEvent(message.document)
      else return null

module.exports = DocumentChangedListener
