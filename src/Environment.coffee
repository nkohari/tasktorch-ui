Cache                   = require 'data/Cache'
ActionsByChecklistStore = require 'data/stores/ActionsByChecklistStore'
ActionStore             = require 'data/stores/ActionStore'
CardStore               = require 'data/stores/CardStore'
CardsByStackStore       = require 'data/stores/CardsByStackStore'
CardsByStageStore       = require 'data/stores/CardsByStageStore'
ChecklistStore          = require 'data/stores/ChecklistStore'
ChecklistsByCardStore   = require 'data/stores/ChecklistsByCardStore'
FollowersByCardStore    = require 'data/stores/FollowersByCardStore'
GoalStore               = require 'data/stores/GoalStore'
KindStore               = require 'data/stores/KindStore'
KindsByOrgStore         = require 'data/stores/KindsByOrgStore'
NoteStore               = require 'data/stores/NoteStore'
MembersByTeamStore      = require 'data/stores/MembersByTeamStore'
MyFollowedCardsStore    = require 'data/stores/MyFollowedCardsStore'
MyOrgsStore             = require 'data/stores/MyOrgsStore'
MyStacksStore           = require 'data/stores/MyStacksStore'
MyTeamsStore            = require 'data/stores/MyTeamsStore'
NotesByCardStore        = require 'data/stores/NotesByCardStore'
OrgStore                = require 'data/stores/OrgStore'
QueueByUserStore        = require 'data/stores/QueueByUserStore'
StackStore              = require 'data/stores/StackStore'
StacksByTeamStore       = require 'data/stores/StacksByTeamStore'
StageStore              = require 'data/stores/StageStore'
StagesByKindStore       = require 'data/stores/StagesByKindStore'
SuggestedTeamsStore     = require 'data/stores/SuggestedTeamsStore'
SuggestedUsersStore     = require 'data/stores/SuggestedUsersStore'
TeamStore               = require 'data/stores/TeamStore'
TeamsByOrgStore         = require 'data/stores/TeamsByOrgStore'
UserStore               = require 'data/stores/UserStore'
EventQueue              = require 'events/EventQueue'
MessageBus              = require 'messaging/MessageBus'
PresenceChannel         = require 'messaging/channels/PresenceChannel'
RemoteChangesChannel    = require 'messaging/channels/RemoteChangesChannel'

class Environment

  constructor: ->

    @eventQueue = new EventQueue()
    @cache      = new Cache(@eventQueue)
    @messageBus = new MessageBus()

    @cache.addStores [
      new ActionStore(@eventQueue, @cache)
      new CardStore(@eventQueue, @cache)
      new ChecklistStore(@eventQueue, @cache)
      new GoalStore(@eventQueue, @cache)
      new KindStore(@eventQueue, @cache)
      new NoteStore(@eventQueue, @cache)
      new OrgStore(@eventQueue, @cache)
      new StackStore(@eventQueue, @cache)
      new StageStore(@eventQueue, @cache)
      new TeamStore(@eventQueue, @cache)
      new UserStore(@eventQueue, @cache)
    ]

    @cache.addStores [
      new ActionsByChecklistStore(@eventQueue, @cache)
      new CardsByStackStore(@eventQueue, @cache)
      new CardsByStageStore(@eventQueue, @cache)
      new ChecklistsByCardStore(@eventQueue, @cache)
      new FollowersByCardStore(@eventQueue, @cache)
      new KindsByOrgStore(@eventQueue, @cache)
      new MembersByTeamStore(@eventQueue, @cache)
      new MyFollowedCardsStore(@eventQueue, @cache)
      new MyOrgsStore(@eventQueue, @cache)
      new MyStacksStore(@eventQueue, @cache)
      new MyTeamsStore(@eventQueue, @cache)
      new QueueByUserStore(@eventQueue, @cache)
      new NotesByCardStore(@eventQueue, @cache)
      new StacksByTeamStore(@eventQueue, @cache)
      new StagesByKindStore(@eventQueue, @cache)
      new SuggestedTeamsStore(@eventQueue, @cache)
      new SuggestedUsersStore(@eventQueue, @cache)
      new TeamsByOrgStore(@eventQueue, @cache)
    ]

    @messageBus.addChannels {
      remoteChanges: new RemoteChangesChannel(@eventQueue, @messageBus)
      presence:      new PresenceChannel(@eventQueue, @messageBus)
    }

module.exports = Environment
