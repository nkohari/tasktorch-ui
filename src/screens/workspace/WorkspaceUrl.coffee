_ = require 'lodash'

keyFor =
  card:  (id) -> "c:#{id}"
  stack: (id) -> "s:#{id}"

class WorkspaceUrl

  constructor: (routes, params, query) ->
    @orgid = params.orgid
    @panels = if query.p? then query.p.split(',') else []

  addStack: (stackid) ->
    @panels.unshift(keyFor.stack(stackid)) unless @isStackActive(stackid)

  addStackBefore: (stackid, cardid) ->
    return if @isStackActive(stackid)
    index = _.indexOf(@panels, keyFor.card(cardid))
    @panels.splice(index, 0, keyFor.stack(stackid))

  removeStack: (stackid) ->
    @panels = _.without(@panels, keyFor.stack(stackid))

  isStackActive: (stackid) ->
    _.contains(@panels, keyFor.stack(stackid))

  addCard: (cardid) ->
    @panels.unshift(keyFor.card(cardid)) unless @isCardActive(cardid)

  addCardAfter: (cardid, stackid) ->
    return if @isCardActive(cardid)
    index = _.indexOf(@panels, keyFor.stack(stackid))
    @panels.splice(index + 1, 0, keyFor.card(cardid))

  removeCard: (cardid) ->
    @panels = _.without(@panels, keyFor.card(cardid))

  isCardActive: (cardid) ->
    _.contains(@panels, keyFor.card(cardid))

  movePanelToPosition: (key, toPosition) ->
    @panels = _.without(@panels, key)
    @panels.splice(toPosition, 0, key)

  makeLinkProps: ->
    params = {@orgid}
    query = {}
    query.p = @panels.join(',') if @panels.length > 0
    return {to: 'workspace', params, query}

module.exports = WorkspaceUrl
