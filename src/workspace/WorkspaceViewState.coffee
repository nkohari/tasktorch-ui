_ = require 'lodash'

class WorkspaceViewState

  constructor: (component) ->

    params = component.getActiveParams()
    query = component.getActiveQuery()

    @organizationId = params.organizationId

    @stacks = if query.stacks? then query.stacks.split(',') else []
    @cards  = if query.cards?  then query.cards.split(',')  else []

  addStack: (stackId) ->
    @stacks.push(stackId) unless _.contains(@stacks, stackId)

  removeStack: (stackId) ->
    @stacks = _.without(@stacks, stackId)

  isStackActive: (stackId) ->
    _.contains(@stacks, stackId)

  addCard: (cardId) ->
    @cards.push(cardId) unless _.contains(@cards, cardId)

  removeCard: (cardId) ->
    @cards = _.without(@cards, cardId)

  isCardActive: (cardId) ->
    _.contains(@cards, cardId)

  makeLinkProps: ->
    params = {@organizationId}
    query = {}
    query.stacks = @stacks.join(',') if @stacks.length > 0
    query.cards  = @cards.join(',')  if @cards.length > 0
    return {to: 'workspace', params, query}

module.exports = WorkspaceViewState
