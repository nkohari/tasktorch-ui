_ = require 'lodash'

class WorkspaceUrl

  constructor: (routes, params, query) ->
    @orgId = params.orgId
    @panels = if query.p? then query.p.split(',') else []

  addStack: (stackId) ->
    @panels.unshift("s:#{stackId}") unless @isStackActive(stackId)

  addStackBefore: (stackId, cardId) ->
    return if @isStackActive(stackId)
    index = _.indexOf(@panels, "c:#{cardId}")
    @panels.splice(index, 0, "s:#{stackId}")

  removeStack: (stackId) ->
    @panels = _.without(@panels, "s:#{stackId}")

  isStackActive: (stackId) ->
    _.contains(@panels, "s:#{stackId}")

  addCard: (cardId) ->
    @panels.unshift("c:#{cardId}") unless @isCardActive(cardId)

  addCardAfter: (cardId, stackId) ->
    return if @isCardActive(cardId)
    index = _.indexOf(@panels, "s:#{stackId}")
    @panels.splice(index + 1, 0, "c:#{cardId}")

  removeCard: (cardId) ->
    @panels = _.without(@panels, "c:#{cardId}")

  isCardActive: (cardId) ->
    _.contains(@panels, "c:#{cardId}")

  movePanelToPosition: (key, toPosition) ->
    @panels = _.without(@panels, key)
    @panels.splice(toPosition, 0, key)

  makeLinkProps: ->
    params = {@orgId}
    query = {}
    query.p = @panels.join(',') if @panels.length > 0
    return {to: 'workspace', params, query}

module.exports = WorkspaceUrl
