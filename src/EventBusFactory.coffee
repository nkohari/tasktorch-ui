EventBus                      = require './EventBus'
ActionStore                   = require './stores/ActionStore'
CardStore                     = require './stores/CardStore'
GoalStore                     = require './stores/GoalStore'
KindStore                     = require './stores/KindStore'
MilestoneStore                = require './stores/MilestoneStore'
OrganizationStore             = require './stores/OrganizationStore'
PresenceStore                 = require './stores/PresenceStore'
QueueStore                    = require './stores/QueueStore'
StackStore                    = require './stores/StackStore'
StageStore                    = require './stores/StageStore'
SuggestionStore               = require './stores/SuggestionStore'
TeamStore                     = require './stores/TeamStore'
UserStore                     = require './stores/UserStore'
CardBodyChangedListener       = require './listeners/CardBodyChangedListener'
CardHandedOffListener         = require './listeners/CardHandedOffListener'
CardTitleChangedListener      = require './listeners/CardTitleChangedListener'
JoinedPresenceChannelListener = require './listeners/JoinedPresenceChannelListener'
UserConnectedListener         = require './listeners/UserConnectedListener'
UserDisconnectedListener      = require './listeners/UserDisconnectedListener'

EventBusFactory = {}

EventBusFactory.create = ->

  stores =
    actions:       new ActionStore()
    cards:         new CardStore()
    goals:         new GoalStore()
    kinds:         new KindStore()
    milestones:    new MilestoneStore()
    organizations: new OrganizationStore()
    presence:      new PresenceStore()
    queue:         new QueueStore()
    stacks:        new StackStore()
    stages:        new StageStore()
    suggestions:   new SuggestionStore()
    teams:         new TeamStore()
    users:         new UserStore()

  listeners = [
    new CardBodyChangedListener()
    new CardHandedOffListener()
    new CardTitleChangedListener()
    new JoinedPresenceChannelListener()
    new UserConnectedListener()
    new UserDisconnectedListener()
  ]

  new EventBus(stores, listeners)

module.exports = EventBusFactory
