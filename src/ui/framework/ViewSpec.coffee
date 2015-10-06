_ = require 'lodash'

class ViewSpec

  @registerPanel: (code, type) ->
    panelSpecTypes = (@panelSpecTypes ?= {})
    panelSpecTypes[code] = type

  constructor: (@screen, query = {}) ->
    @drawer = true
    @panels = []

    if query.d?
      try
        @drawer = Boolean(Number(query.d))
      catch err

    if query.p?
      try
        @panels = _.map query.p.split('-'), (str) =>
          code = str[0]
          @constructor.panelSpecTypes[code].fromTokens(str)
      catch err

  addPanel: (panel, position = undefined) ->
    unless @isPanelOpen(panel.id)
      if position?
        @panels.splice(position, 0, panel)
      else
        @panels.unshift(panel)

  addPanelAfter: (panel, otherid) ->
    @addPanel(panel, @getIndexOfPanel(otherid) + 1)

  addPanelBefore: (panel, otherid) ->
    @addPanel(panel, @getIndexOfPanel(otherid))

  removePanel: (id) ->
    @panels = _.filter @panels, (p) -> p.id != id

  movePanel: (id, newPosition) ->
    panel = _.find @panels, (p) -> p.id == id
    @removePanel(id)
    @addPanel(panel, newPosition)

  togglePanel: (panel) ->
    if @isPanelOpen(panel.id)
      @removePanel(panel.id)
    else
      @addPanel(panel)

  getOpenPanels: ->
    @panels

  getIndexOfPanel: (id) ->
    _.findIndex @panels, (p) -> p.id == id

  isPanelOpen: (id) ->
    _.any @panels, (p) -> p.id == id

  openDrawer: ->
    @drawer = true

  closeDrawer: ->
    @drawer = false

  toggleDrawer: ->
    @drawer = !@drawer

  isDrawerOpen: ->
    @drawer

  getUrl: (identity, history) ->

    path = "/#{identity.orgid}/#{@screen}"
    query = {}

    if not @drawer
      query.d = 0

    if @panels.length > 0
      query.p = _.map(@panels, (p) -> p.serialize()).join('-')

    history.createHref(path, query)

module.exports = ViewSpec
