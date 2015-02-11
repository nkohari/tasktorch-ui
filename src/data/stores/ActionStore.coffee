_                        = require 'lodash'
Store                    = require 'framework/Store'
LoadActionsByCardRequest = require 'requests/LoadActionsByCardRequest'

class ActionStore extends Store

  displayName: 'ActionStore'

  getAllByCard: (cardid) ->
    actions = _.filter(@items, (action) -> action.card == cardid)
    _.sortBy(actions, 'rank')

  onCardActionListDisplayed: (event) ->
    if @getMany(event.actionids)?
      @announce()
    else
      @execute new LoadActionsByCardRequest(event.cardid)

  onActionsLoaded: (event) ->
    @add(event.actions)

  onActionCreated: (event) ->
    @add(event.action)

  onActionDeleted: (event) ->
    @remove(event.action)

  onActionChanged: (event) ->
    @add(event.action)

module.exports = ActionStore
