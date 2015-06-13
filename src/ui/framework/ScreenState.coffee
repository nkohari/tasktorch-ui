_                   = require 'lodash'
GoalPanelState      = require 'ui/screens/bigPicture/panels/goal/GoalPanelState'
KindPanelState      = require 'ui/screens/bigPicture/panels/kind/KindPanelState'
TeamPanelState      = require 'ui/screens/bigPicture/panels/team/TeamPanelState'
CardPanelState      = require 'ui/screens/workspace/panels/card/CardPanelState'
FollowingPanelState = require 'ui/screens/workspace/panels/following/FollowingPanelState'
StackPanelState     = require 'ui/screens/workspace/panels/stack/StackPanelState'

VALUE_SEPARATOR  = '.'
OBJECT_SEPARATOR = '-'

class ScreenState

  constructor: (@name, url, @transitionTo) ->

    @drawer = false
    @panels  = []
    @orgid   = url.params.orgid

    if url.screen == name
      @drawer = !!url.query.d if url.query.d?
      if url.query.p?
        try
          @panels = _.map url.query.p.split(OBJECT_SEPARATOR), (blob) => @deserialize(blob)
        catch err
          console.warn("Error deserializing panel state: #{err}")
      console.log(@panels)

  showDrawer: ->
    @drawer = true
    @navigate()

  hideDrawer: ->
    @drawer = false
    @navigate()

  toggleDrawer: ->
    @drawer = !@drawer
    @navigate()

  addPanel: (panel, position = undefined) ->
    unless @isPanelVisible(panel.id)
      if position?
        @panels.splice(position, 0, panel)
      else
        @panels.unshift(panel)
    @navigate()

  removePanel: (id) ->
    @panels = _.filter @panels, (p) -> p.id != id
    @navigate()

  togglePanel: (panel) ->
    if @isPanelVisible(panel.id)
      @removePanel(panel.id)
    else
      @addPanel(panel)

  addPanelAfter: (otherid, panel) ->
    console.log "index of #{otherid} is #{@getIndexOfPanel(otherid)}"
    @addPanel(panel, @getIndexOfPanel(otherid) + 1)

  addPanelBefore: (otherid, panel) ->
    @addPanel(panel, @getIndexOfPanel(otherid))

  getIndexOfPanel: (id) ->
    _.findIndex @panels, (p) -> p.id == id

  isPanelVisible: (id) ->
    _.any @panels, (p) -> p.id == id

  isDrawerVisible: ->
    @drawer

  getProps: ->

    query = {}
    query.d = 1 if @drawer

    if @panels.length > 0
      query.p = _.map(@panels, (p) => @serialize(p)).join(OBJECT_SEPARATOR)

    return {
      to:     @name
      params: {@orgid}
      query:  query
    }

  navigate: ->
    props = @getProps()
    @transitionTo(props.to, props.params, props.query)

  serialize: (panel) ->
    [panel.type, panel.id].join(VALUE_SEPARATOR)

  deserialize: (str) ->
    [type, id] = str.split(VALUE_SEPARATOR)
    switch type
      when CardPanelState.type      then new CardPanelState(id)
      when FollowingPanelState.type then new FollowingPanelState(id)
      when GoalPanelState.type      then new GoalPanelState(id)
      when KindPanelState.type      then new KindPanelState(id)
      when StackPanelState.type     then new StackPanelState(id)
      when TeamPanelState.type      then new TeamPanelState(id)

module.exports = ScreenState
