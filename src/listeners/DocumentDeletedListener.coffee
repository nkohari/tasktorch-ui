Listener           = require 'framework/Listener'
ActionDeletedEvent = require 'events/delete/ActionDeletedEvent'
StackDeletedEvent  = require 'events/delete/StackDeletedEvent'
TeamDeletedEvent   = require 'events/delete/TeamDeletedEvent'

class DocumentDeletedListener extends Listener

  listensFor: 'Deleted'

  createEvent: (message) ->
    switch message.type
      when 'Action' then return new ActionDeletedEvent(message.document)
      when 'Stack'  then return new StackDeletedEvent(message.document)
      when 'Team'   then return new TeamDeletedEvent(message.document)
      else return null

module.exports = DocumentDeletedListener
