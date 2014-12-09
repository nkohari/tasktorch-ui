_     = require 'lodash'
Store = require 'framework/Store'

class ActionStore extends Store

  constructor: ->
    @actions = {}

  getAction: (id) ->
    @actions[id]

  getActionsByCard: (cardId) ->
    actions = _.filter(@actions, (action) -> action.card == cardId)
    _.sortBy(actions, 'rank')

  onActionsLoaded: (event) ->
    @actions = _.extend @actions, _.indexBy(event.actions, 'id')
    @announce()

module.exports = ActionStore
