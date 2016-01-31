Channel                = require 'messaging/framework/Channel'
EventOrigin            = require 'data/enums/EventOrigin'
Action                 = require 'data/models/Action'
Card                   = require 'data/models/Card'
Checklist              = require 'data/models/Checklist'
File                   = require 'data/models/File'
Goal                   = require 'data/models/Goal'
Kind                   = require 'data/models/Kind'
Membership             = require 'data/models/Membership'
Org                    = require 'data/models/Org'
Note                   = require 'data/models/Note'
Profile                = require 'data/models/Profile'
Stack                  = require 'data/models/Stack'
Stage                  = require 'data/models/Stage'
Team                   = require 'data/models/Team'
User                   = require 'data/models/User'
ActionChangedEvent     = require 'events/change/ActionChangedEvent'
ActionCreatedEvent     = require 'events/create/ActionCreatedEvent'
ActionDeletedEvent     = require 'events/delete/ActionDeletedEvent'
CardChangedEvent       = require 'events/change/CardChangedEvent'
CardCreatedEvent       = require 'events/create/CardCreatedEvent'
ChecklistChangedEvent  = require 'events/change/ChecklistChangedEvent'
ChecklistCreatedEvent  = require 'events/create/ChecklistCreatedEvent'
FileChangedEvent       = require 'events/change/FileChangedEvent'
FileCreatedEvent       = require 'events/create/FileCreatedEvent'
FileDeletedEvent       = require 'events/delete/FileDeletedEvent'
GoalChangedEvent       = require 'events/change/GoalChangedEvent'
GoalCreatedEvent       = require 'events/create/GoalCreatedEvent'
KindChangedEvent       = require 'events/change/KindChangedEvent'
KindCreatedEvent       = require 'events/create/KindCreatedEvent'
MembershipChangedEvent = require 'events/change/MembershipChangedEvent'
MembershipCreatedEvent = require 'events/create/MembershipCreatedEvent'
NoteChangedEvent       = require 'events/change/NoteChangedEvent'
NoteCreatedEvent       = require 'events/create/NoteCreatedEvent'
OrgChangedEvent        = require 'events/change/OrgChangedEvent'
ProfileChangedEvent    = require 'events/change/ProfileChangedEvent'
StackChangedEvent      = require 'events/change/StackChangedEvent'
StackCreatedEvent      = require 'events/create/StackCreatedEvent'
StackDeletedEvent      = require 'events/delete/StackDeletedEvent'
StageChangedEvent      = require 'events/change/StageChangedEvent'
StageCreatedEvent      = require 'events/create/StageCreatedEvent'
TeamChangedEvent       = require 'events/change/TeamChangedEvent'
TeamCreatedEvent       = require 'events/create/TeamCreatedEvent'
TeamDeletedEvent       = require 'events/delete/TeamDeletedEvent'
UserChangedEvent       = require 'events/change/UserChangedEvent'

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
      when 'Action'     then @publish new ActionCreatedEvent(new Action(message.document), EventOrigin.Remote)
      when 'Card'       then @publish new CardCreatedEvent(new Card(message.document), EventOrigin.Remote)
      when 'Checklist'  then @publish new ChecklistCreatedEvent(new Checklist(message.document), EventOrigin.Remote)
      when 'File'       then @publish new FileCreatedEvent(new File(message.document), EventOrigin.Remote)
      when 'Goal'       then @publish new GoalCreatedEvent(new Goal(message.document), EventOrigin.Remote)
      when 'Kind'       then @publish new KindCreatedEvent(new Kind(message.document), EventOrigin.Remote)
      when 'Membership' then @publish new MembershipCreatedEvent(new Membership(message.document), EventOrigin.Remote)
      when 'Note'       then @publish new NoteCreatedEvent(new Note(message.document), EventOrigin.Remote)
      when 'Stack'      then @publish new StackCreatedEvent(new Stack(message.document), EventOrigin.Remote)
      when 'Stage'      then @publish new StageCreatedEvent(new Stage(message.document), EventOrigin.Remote)
      when 'Team'       then @publish new TeamCreatedEvent(new Team(message.document), EventOrigin.Remote)

  onDocumentChanged: (message) ->
    debug.log(message)
    switch message.type
      when 'Action'     then @publish new ActionChangedEvent(new Action(message.document), EventOrigin.Remote)
      when 'Card'       then @publish new CardChangedEvent(new Card(message.document), EventOrigin.Remote)
      when 'Checklist'  then @publish new ChecklistChangedEvent(new Checklist(message.document), EventOrigin.Remote)
      when 'File'       then @publish new FileChangedEvent(new File(message.document), EventOrigin.Remote)
      when 'Goal'       then @publish new GoalChangedEvent(new Goal(message.document), EventOrigin.Remote)
      when 'Kind'       then @publish new KindChangedEvent(new Kind(message.document), EventOrigin.Remote)
      when 'Membership' then @publish new MembershipChangedEvent(new Membership(message.document), EventOrigin.Remote)
      when 'Note'       then @publish new NoteChangedEvent(new Note(message.document), EventOrigin.Remote)
      when 'Org'        then @publish new OrgChangedEvent(new Org(message.document), EventOrigin.Remote)
      when 'Profile'    then @publish new ProfileChangedEvent(new Profile(message.document), EventOrigin.Remote)
      when 'Stack'      then @publish new StackChangedEvent(new Stack(message.document), EventOrigin.Remote)
      when 'Stage'      then @publish new StageChangedEvent(new Stage(message.document), EventOrigin.Remote)
      when 'Team'       then @publish new TeamChangedEvent(new Team(message.document), EventOrigin.Remote)
      when 'User'       then @publish new UserChangedEvent(new User(message.document), EventOrigin.Remote)

  onDocumentDeleted: (message) ->
    switch message.type
      when 'Action' then @publish new ActionDeletedEvent(new Action(message.document), EventOrigin.Remote)
      when 'File'   then @publish new FileDeletedEvent(new File(message.document), EventOrigin.Remote)
      when 'Stack'  then @publish new StackDeletedEvent(new Stack(message.document), EventOrigin.Remote)
      when 'Team'   then @publish new TeamDeletedEvent(new Team(message.document), EventOrigin.Remote)

module.exports = RemoteChangesChannel
