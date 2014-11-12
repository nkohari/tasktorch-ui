EventBus                      = require './EventBus'
CardStore                     = require './stores/CardStore'
GoalStore                     = require './stores/GoalStore'
MilestoneStore                = require './stores/MilestoneStore'
OrganizationStore             = require './stores/OrganizationStore'
PresenceStore                 = require './stores/PresenceStore'
QueueStore                    = require './stores/QueueStore'
StackStore                    = require './stores/StackStore'
TeamStore                     = require './stores/TeamStore'
KindStore                     = require './stores/KindStore'
UserStore                     = require './stores/UserStore'
CardBodyChangedListener       = require './listeners/CardBodyChangedListener'
CardTitleChangedListener      = require './listeners/CardTitleChangedListener'
JoinedPresenceChannelListener = require './listeners/JoinedPresenceChannelListener'
UserConnectedListener         = require './listeners/UserConnectedListener'
UserDisconnectedListener      = require './listeners/UserDisconnectedListener'

EventBusFactory = {}

EventBusFactory.create = ->

  stores =
    cards:         new CardStore()
    goals:         new GoalStore()
    kinds:         new KindStore()
    milestones:    new MilestoneStore()
    organizations: new OrganizationStore()
    presence:      new PresenceStore()
    queue:         new QueueStore()
    stacks:        new StackStore()
    teams:         new TeamStore()
    users:         new UserStore()

  listeners = [
    new CardBodyChangedListener()
    new CardTitleChangedListener()
    new JoinedPresenceChannelListener()
    new UserConnectedListener()
    new UserDisconnectedListener()
  ]

  new EventBus(stores, listeners)

module.exports = EventBusFactory
