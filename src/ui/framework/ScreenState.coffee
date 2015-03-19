_ = require 'lodash'

class ScreenState

  constructor: (@name, url, @transitionTo) ->

    @sidebar = false
    @panels  = []
    @orgid   = url.params.orgid

    if url.screen == name
      @sidebar = !!url.query.s           if url.query.s?
      @panels  = JSON.parse(url.query.p) if url.query.p?

  showSidebar: ->
    @sidebar = true
    @navigate()

  hideSidebar: ->
    @sidebar = false
    @navigate()

  toggleSidebar: ->
    @sidebar = !@sidebar
    @navigate()

  showPanel: (panel, position = undefined) ->
    return if @isPanelVisible(panel.id)

    if position?
      @panels.splice(position, 0, panel)
    else
      @panels.unshift(panel)

    @navigate()

  hidePanel: (id) ->
    @panels = _.filter @panels, (p) -> p.id != id
    @navigate()

  togglePanel: (panel) ->
    if @isPanelVisible(panel.id)
      @hidePanel(panel.id)
    else
      @showPanel(panel)

  showPanelAfter: (otherid, panel) ->
    console.log "index of #{otherid} is #{@getIndexOfPanel(otherid)}"
    @showPanel(panel, @getIndexOfPanel(otherid) + 1)

  showPanelBefore: (otherid, panel) ->
    @showPanel(panel, @getIndexOfPanel(otherid))

  getIndexOfPanel: (id) ->
    _.findIndex @panels, (p) -> p.id == id

  isPanelVisible: (id) ->
    _.any @panels, (p) -> p.id == id

  isSidebarVisible: ->
    @sidebar

  getProps: ->

    query = {}
    query.s = @sidebar if @sidebar
    query.p = JSON.stringify(@panels) if @panels.length > 0

    return {
      to:     @name
      params: {@orgid}
      query:  query
    }

  navigate: ->
    props = @getProps()
    @transitionTo(props.to, props.params, props.query)

module.exports = ScreenState
