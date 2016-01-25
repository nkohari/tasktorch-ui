Card                          = require 'data/models/Card'
ModelStore                    = require 'data/framework/ModelStore'
AcceptCardRequest             = require 'data/requests/AcceptCardRequest'
CompleteCardRequest           = require 'data/requests/CompleteCardRequest'
CreateCardRequest             = require 'data/requests/CreateCardRequest'
DeleteCardRequest             = require 'data/requests/DeleteCardRequest'
LoadCardRequest               = require 'data/requests/LoadCardRequest'
MoveCardRequest               = require 'data/requests/MoveCardRequest'
PassCardRequest               = require 'data/requests/PassCardRequest'
ChangeCardDueDateRequest      = require 'data/requests/ChangeCardDueDateRequest'
ChangeCardSummaryRequest      = require 'data/requests/ChangeCardSummaryRequest'
ChangeCardTitleRequest        = require 'data/requests/ChangeCardTitleRequest'
AddFollowerToCardRequest      = require 'data/requests/AddFollowerToCardRequest'
RemoveFollowerFromCardRequest = require 'data/requests/RemoveFollowerFromCardRequest'
RestoreCardRequest            = require 'data/requests/RestoreCardRequest'
AddCardToGoalRequest          = require 'data/requests/AddCardToGoalRequest'
RemoveCardFromGoalRequest     = require 'data/requests/RemoveCardFromGoalRequest'

class CardStore extends ModelStore

  displayName: 'CardStore'
  name:        'cards'
  modelType:   Card

  listensFor: [
    'CardsLoaded'
    'CardCreated'
    'CardChanged'
    'CardDeleted'
    'UserAcceptedCard'
    'UserCompletedCard'
    'UserCreatedCard'
    'UserDeletedCard'
    'UserMovedCard'
    'UserPassedCard'
    'UserChangedCardDueDate'
    'UserChangedCardSummary'
    'UserChangedCardTitle'
    'UserFollowedCard'
    'UserUnfollowedCard'
    'UserRestoredCard'
    'UserAddedCardToGoal'
    'UserRemovedCardFromGoal'
  ]

  load: (cardid) ->
    @execute new LoadCardRequest(cardid)

  onCardsLoaded: (event) ->
    @add(event.cards)

  onCardCreated: (event) ->
    @add(event.card)

  onCardChanged: (event) ->
    @add(event.card)

  onCardDeleted: (event) ->
    @add(event.card)

  onUserAcceptedCard: (event) ->
    @execute new AcceptCardRequest(event.cardid, event.preempt)

  onUserCompletedCard: (event) ->
    @execute new CompleteCardRequest(event.cardid)

  onUserCreatedCard: (event) ->
    @execute new CreateCardRequest(event.orgid, event.kindid)

  onUserDeletedCard: (event) ->
    @execute new DeleteCardRequest(event.cardid)

  onUserMovedCard: (event) ->
    @execute new MoveCardRequest(event.cardid, event.stackid, event.position)

  onUserPassedCard: (event) ->
    @execute new PassCardRequest(event.cardid, event.recipient, event.message)

  onUserChangedCardDueDate: (event) ->
    @execute new ChangeCardDueDateRequest(event.cardid, event.due)

  onUserChangedCardSummary: (event) ->
    @execute new ChangeCardSummaryRequest(event.cardid, event.summary)

  onUserChangedCardTitle: (event) ->
    @execute new ChangeCardTitleRequest(event.cardid, event.title)

  onUserFollowedCard: (event) ->
    @execute new AddFollowerToCardRequest(event.cardid, event.userid)

  onUserUnfollowedCard: (event) ->
    @execute new RemoveFollowerFromCardRequest(event.cardid, event.userid)

  onUserRestoredCard: (event) ->
    @execute new RestoreCardRequest(event.cardid)
    
  onUserAddedCardToGoal: (event) ->
    @execute new AddCardToGoalRequest(event.goalid, event.cardid)

  onUserRemovedCardFromGoal: (event) ->
    @execute new RemoveCardFromGoalRequest(event.goalid, event.cardid)

module.exports = CardStore
