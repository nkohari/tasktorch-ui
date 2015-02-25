Channel            = require 'messaging/framework/Channel'
EventOrigin        = require 'data/enums/EventOrigin'
Action             = require 'data/models/Action'
Card               = require 'data/models/Card'
Note               = require 'data/models/Note'
Stack              = require 'data/models/Stack'
Team               = require 'data/models/Team'
User               = require 'data/models/User'
ActionChangedEvent = require 'events/change/ActionChangedEvent'
ActionCreatedEvent = require 'events/create/ActionCreatedEvent'
ActionDeletedEvent = require 'events/delete/ActionDeletedEvent'
CardChangedEvent   = require 'events/change/CardChangedEvent'
CardCreatedEvent   = require 'events/create/CardCreatedEvent'
NoteCreatedEvent   = require 'events/create/NoteCreatedEvent'
StackChangedEvent  = require 'events/change/StackChangedEvent'
StackCreatedEvent  = require 'events/create/StackCreatedEvent'
StackDeletedEvent  = require 'events/delete/StackDeletedEvent'
TeamChangedEvent   = require 'events/change/TeamChangedEvent'
TeamCreatedEvent   = require 'events/create/TeamCreatedEvent'
TeamDeletedEvent   = require 'events/delete/TeamDeletedEvent'
UserChangedEvent   = require 'events/change/UserChangedEvent'

class RemoteChangesChannel extends Channel

  displayName: 'RemoteChangesChannel'

  listensFor: [
    'UserSelectedOrg'
  ]

  onUserSelectedOrg: (event) ->
    channel = @messageBus.subscribe("private-user-#{event.userid}")
    channel.bind('Created', @onDocumentCreated, this)
    channel.bind('Changed', @onDocumentChanged, this)
    channel.bind('Deleted', @onDocumentDeleted, this)

  onDocumentCreated: (message) ->
    switch message.type
      when 'Action' then @publish new ActionCreatedEvent(new Action(message.document), EventOrigin.Remote)
      when 'Card'   then @publish new CardCreatedEvent(new Card(message.document), EventOrigin.Remote)
      when 'Note'   then @publish new NoteCreatedEvent(new Note(message.document), EventOrigin.Remote)
      when 'Stack'  then @publish new StackCreatedEvent(new Stack(message.document), EventOrigin.Remote)
      when 'Team'   then @publish new TeamCreatedEvent(new Team(message.document), EventOrigin.Remote)

  onDocumentChanged: (message) ->
    switch message.type
      when 'Action' then @publish new ActionChangedEvent(new Action(message.document), EventOrigin.Remote)
      when 'Card'   then @publish new CardChangedEvent(new Card(message.document), EventOrigin.Remote)
      when 'Stack'  then @publish new StackChangedEvent(new Stack(message.document), EventOrigin.Remote)
      when 'Team'   then @publish new TeamChangedEvent(new Team(message.document), EventOrigin.Remote)
      when 'User'   then @publish new UserChangedEvent(new User(message.document), EventOrigin.Remote)

  onDocumentDeleted: (message) ->
    switch message.type
      when 'Action' then @publish new ActionDeletedEvent(new Action(message.document), EventOrigin.Remote)
      when 'Stack'  then @publish new StackDeletedEvent(new Stack(message.document), EventOrigin.Remote)
      when 'Team'   then @publish new TeamDeletedEvent(new Team(message.document), EventOrigin.Remote)

module.exports = RemoteChangesChannel
