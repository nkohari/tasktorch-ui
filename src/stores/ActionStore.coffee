_     = require 'lodash'
Store = require 'framework/Store'

class ActionStore extends Store

  getAllByCard: (cardId) ->
    actions = _.filter(@items, (action) -> action.card == cardId)
    _.sortBy(actions, 'rank')

  onActionsLoaded: (event) ->
    @add(event.actions)

module.exports = ActionStore
