Card                          = require 'data/models/Card'
ModelStore                    = require 'data/framework/ModelStore'
AcceptCardRequest             = require 'data/requests/AcceptCardRequest'
CompleteCardRequest           = require 'data/requests/CompleteCardRequest'
CreateCardRequest             = require 'data/requests/CreateCardRequest'
DeleteCardRequest             = require 'data/requests/DeleteCardRequest'
LoadCardRequest               = require 'data/requests/LoadCardRequest'
MoveCardRequest               = require 'data/requests/MoveCardRequest'
PassCardRequest               = require 'data/requests/PassCardRequest'
ChangeCardSummaryRequest      = require 'data/requests/ChangeCardSummaryRequest'
ChangeCardTitleRequest        = require 'data/requests/ChangeCardTitleRequest'
AddFollowerToCardRequest      = require 'data/requests/AddFollowerToCardRequest'
RemoveFollowerFromCardRequest = require 'data/requests/RemoveFollowerFromCardRequest'

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
    'UserChangedCardSummary'
    'UserChangedCardTitle'
    'UserFollowedCard'
    'UserUnfollowedCard'
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

  onUserChangedCardSummary: (event) ->
    @execute new ChangeCardSummaryRequest(event.cardid, event.summary)

  onUserChangedCardTitle: (event) ->
    @execute new ChangeCardTitleRequest(event.cardid, event.title)

  onUserFollowedCard: (event) ->
    @execute new AddFollowerToCardRequest(event.cardid, event.userid)

  onUserUnfollowedCard: (event) ->
    @execute new RemoveFollowerFromCardRequest(event.cardid, event.userid)
    
module.exports = CardStore
