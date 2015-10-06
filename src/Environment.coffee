Cache                   = require 'data/Cache'
Processor               = require 'data/Processor'
ActionsByChecklistStore = require 'data/stores/ActionsByChecklistStore'
ActionStore             = require 'data/stores/ActionStore'
CardStore               = require 'data/stores/CardStore'
CardsByGoalStore        = require 'data/stores/CardsByGoalStore'
CardsByStackStore       = require 'data/stores/CardsByStackStore'
CardsByStageStore       = require 'data/stores/CardsByStageStore'
ChecklistStore          = require 'data/stores/ChecklistStore'
ChecklistsByCardStore   = require 'data/stores/ChecklistsByCardStore'
DialogStore             = require 'data/stores/DialogStore'
FollowersByCardStore    = require 'data/stores/FollowersByCardStore'
GoalStore               = require 'data/stores/GoalStore'
GoalsByCardStore        = require 'data/stores/GoalsByCardStore'
GoalsByOrgStore         = require 'data/stores/GoalsByOrgStore'
InviteStore             = require 'data/stores/InviteStore'
KindStore               = require 'data/stores/KindStore'
KindsByOrgStore         = require 'data/stores/KindsByOrgStore'
NoteStore               = require 'data/stores/NoteStore'
MembersByTeamStore      = require 'data/stores/MembersByTeamStore'
MyFollowedCardsStore    = require 'data/stores/MyFollowedCardsStore'
MyOrgsStore             = require 'data/stores/MyOrgsStore'
MyStacksStore           = require 'data/stores/MyStacksStore'
MyTeamsStore            = require 'data/stores/MyTeamsStore'
NotesByCardStore        = require 'data/stores/NotesByCardStore'
OnlineUsersStore        = require 'data/stores/OnlineUsersStore'
OrgStore                = require 'data/stores/OrgStore'
ProfileStore            = require 'data/stores/ProfileStore'
QueueByUserStore        = require 'data/stores/QueueByUserStore'
StackStore              = require 'data/stores/StackStore'
StacksByTeamStore       = require 'data/stores/StacksByTeamStore'
StageStore              = require 'data/stores/StageStore'
StagesByKindStore       = require 'data/stores/StagesByKindStore'
SuggestedTeamsStore     = require 'data/stores/SuggestedTeamsStore'
SuggestedUsersStore     = require 'data/stores/SuggestedUsersStore'
TeamStore               = require 'data/stores/TeamStore'
TeamsByOrgStore         = require 'data/stores/TeamsByOrgStore'
TeamsByUserStore        = require 'data/stores/TeamsByUserStore'
TokenStore              = require 'data/stores/TokenStore'
UserStore               = require 'data/stores/UserStore'
UsersByOrgStore         = require 'data/stores/UsersByOrgStore'
EventQueue              = require 'events/EventQueue'
MessageBus              = require 'messaging/MessageBus'
PresenceChannel         = require 'messaging/channels/PresenceChannel'
RemoteChangesChannel    = require 'messaging/channels/RemoteChangesChannel'
ViewMaster              = require 'ui/framework/ViewMaster'

class Environment

  constructor: (@history) ->

    @eventQueue = new EventQueue()
    @cache      = new Cache(@eventQueue)
    @viewMaster = new ViewMaster(@eventQueue, @history)
    @processor  = new Processor(@eventQueue, @viewMaster)
    @messageBus = new MessageBus()

    createStore = (type) =>
      new type(@eventQueue, @processor, @cache)

    @cache.addStores [
      createStore(ActionStore)
      createStore(CardStore)
      createStore(ChecklistStore)
      createStore(DialogStore)
      createStore(GoalStore)
      createStore(InviteStore)
      createStore(KindStore)
      createStore(NoteStore)
      createStore(OrgStore)
      createStore(ProfileStore)
      createStore(StackStore)
      createStore(StageStore)
      createStore(TeamStore)
      createStore(TokenStore)
      createStore(UserStore)
    ]

    @cache.addStores [
      createStore(ActionsByChecklistStore)
      createStore(CardsByGoalStore)
      createStore(CardsByStackStore)
      createStore(CardsByStageStore)
      createStore(ChecklistsByCardStore)
      createStore(FollowersByCardStore)
      createStore(GoalsByCardStore)
      createStore(GoalsByOrgStore)
      createStore(KindsByOrgStore)
      createStore(MembersByTeamStore)
      createStore(MyFollowedCardsStore)
      createStore(MyOrgsStore)
      createStore(MyStacksStore)
      createStore(MyTeamsStore)
      createStore(OnlineUsersStore)
      createStore(NotesByCardStore)
      createStore(QueueByUserStore)
      createStore(StacksByTeamStore)
      createStore(StagesByKindStore)
      createStore(SuggestedTeamsStore)
      createStore(SuggestedUsersStore)
      createStore(TeamsByOrgStore)
      createStore(TeamsByUserStore)
      createStore(UsersByOrgStore)
    ]

    @messageBus.addChannels {
      remoteChanges: new RemoteChangesChannel(@eventQueue, @messageBus)
      presence:      new PresenceChannel(@eventQueue, @messageBus)
    }

  get: (name) ->
    unless this[name]?
      throw new Error("[Environment] Unknown service requested: #{name}")
    this[name]

module.exports = Environment
