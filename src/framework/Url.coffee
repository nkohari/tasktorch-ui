_ = require 'lodash'

keyFor =
  card:  (id) -> "c:#{id}"
  stack: (id) -> "s:#{id}"
  following: 'f'

class Url

  constructor: (@component) ->

    routes = @component.getRoutes()
    params = @component.getParams()
    query  = @component.getQuery()

    @screen  = routes[1].name
    @orgid   = params.orgid
    @sidebar = query.s != 'n'
    @panels  = if query.p? then query.p.split(',') else []

  addStack: (stackid) ->
    @panels.unshift(keyFor.stack(stackid)) unless @isStackActive(stackid)

  addStackBefore: (stackid, cardid) ->
    return if @isStackActive(stackid)
    index = _.indexOf(@panels, keyFor.card(cardid))
    @panels.splice(index, 0, keyFor.stack(stackid))

  removeStack: (stackid) ->
    @panels = _.without(@panels, keyFor.stack(stackid))

  toggleStack: (stackid) ->
    if @isStackActive(stackid)
      @removeStack(stackid)
    else
      @addStack(stackid)

  isStackActive: (stackid) ->
    _.contains(@panels, keyFor.stack(stackid))

  addCard: (cardid) ->
    @panels.unshift(keyFor.card(cardid)) unless @isCardActive(cardid)

  addCardAfterStack: (cardid, stackid) ->
    return if @isCardActive(cardid)
    index = _.indexOf(@panels, keyFor.stack(stackid))
    @panels.splice(index + 1, 0, keyFor.card(cardid))

  addCardAfterPanel: (cardid, panel) ->
    return if @isCardActive(cardid)
    index = _.indexOf(@panels, panel)
    @panels.splice(index + 1, 0, keyFor.card(cardid))

  removeCard: (cardid) ->
    @panels = _.without(@panels, keyFor.card(cardid))

  toggleCard: (cardid) ->
    if @isCardActive(cardid)
      @removeCard(cardid)
    else
      @addCard(cardid)

  isCardActive: (cardid) ->
    _.contains(@panels, keyFor.card(cardid))

  movePanelToPosition: (key, toPosition) ->
    @panels = _.without(@panels, key)
    @panels.splice(toPosition, 0, key)

  toggleSidebar: ->
    @sidebar = !@sidebar

  showFollowing: ->
    @panels.unshift(keyFor.following) unless @isFollowingActive()

  hideFollowing: ->
    @panels = _.without(@panels, keyFor.following)

  isFollowingActive: ->
    _.contains(@panels, keyFor.following)

  toggleFollowing: ->
    if @isFollowingActive()
      @hideFollowing()
    else
      @showFollowing()

  makeLinkProps: (props = {}) ->

    params = {@orgid}

    query = {}
    query.s = if not @sidebar then 'n' else undefined
    query.p = if @panels.length > 0 then @panels.join(',') else undefined

    return _.extend props, {
      to:     @screen
      params: _.extend(@component.getParams(), params)
      query:  _.extend(@component.getQuery(),  query)
    }

module.exports = Url
