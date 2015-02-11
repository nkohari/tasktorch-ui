EventBus                      = require './EventBus'
ActionStore                   = require './data/stores/ActionStore'
CardStore                     = require './data/stores/CardStore'
ConnectedUserStore            = require './data/stores/ConnectedUserStore'
GoalStore                     = require './data/stores/GoalStore'
KindStore                     = require './data/stores/KindStore'
MilestoneStore                = require './data/stores/MilestoneStore'
NoteStore                     = require './data/stores/NoteStore'
OrgStore                      = require './data/stores/OrgStore'
QueueStore                    = require './data/stores/QueueStore'
StackStore                    = require './data/stores/StackStore'
StageStore                    = require './data/stores/StageStore'
SuggestionStore               = require './data/stores/SuggestionStore'
TeamStore                     = require './data/stores/TeamStore'
UserStore                     = require './data/stores/UserStore'
DocumentCreatedListener       = require './framework/listeners/DocumentCreatedListener'
DocumentChangedListener       = require './framework/listeners/DocumentChangedListener'
DocumentDeletedListener       = require './framework/listeners/DocumentDeletedListener'
JoinedPresenceChannelListener = require './framework/listeners/JoinedPresenceChannelListener'
UserConnectedListener         = require './framework/listeners/UserConnectedListener'
UserDisconnectedListener      = require './framework/listeners/UserDisconnectedListener'

EventBusFactory = {}

EventBusFactory.create = ->

  stores =
    actions:        new ActionStore()
    cards:          new CardStore()
    goals:          new GoalStore()
    kinds:          new KindStore()
    milestones:     new MilestoneStore()
    notes:          new NoteStore()
    orgs:           new OrgStore()
    connectedUsers: new ConnectedUserStore()
    queue:          new QueueStore()
    stacks:         new StackStore()
    stages:         new StageStore()
    suggestions:    new SuggestionStore()
    teams:          new TeamStore()
    users:          new UserStore()

  listeners = [
    new DocumentCreatedListener()
    new DocumentChangedListener()
    new DocumentDeletedListener()
    new JoinedPresenceChannelListener()
    new UserConnectedListener()
    new UserDisconnectedListener()
  ]

  new EventBus(stores, listeners)

module.exports = EventBusFactory
