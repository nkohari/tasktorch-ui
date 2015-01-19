_                        = require 'lodash'
Store                    = require 'framework/Store'
LoadActionsByCardRequest = require 'requests/LoadActionsByCardRequest'

class ActionStore extends Store

  getAllByCard: (cardId) ->
    actions = _.filter(@items, (action) -> action.card == cardId)
    _.sortBy(actions, 'rank')

  onCardActionListDisplayed: (event) ->
    if @getMany(event.actionIds)?
      @announce()
    else
      @execute new LoadActionsByCardRequest(event.cardId)

  onActionsLoaded: (event) ->
    @add(event.actions)

  onActionCreated: (event) ->
    @add(event.action)

  onActionChanged: (event) ->
    @add(event.action)

module.exports = ActionStore
