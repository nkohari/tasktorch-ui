_ = require 'lodash'

STATE_PROPS = ['path', 'screen', 'params', 'query']

class UrlModel

  constructor: (state) ->
    _.extend(this, _.pick(state, STATE_PROPS))

  getScreen: ->
    @screen

  getSidebar: ->
    @query.s == 'y'

  getPanels: ->
    if @query.p? then @query.p.split(',') else []

  addPanel: (key, index = undefined) ->

    panels = @getPanels()

    unless _.contains(panels, key)
      if index?
        panels.splice(index, 0, key)
      else
        panels.unshift(key)

    @clone {
      query: {p: panels.join(',')}
    }

  addPanelBefore: (key, otherKey) ->
    index = @getPanelPosition(otherKey)
    @addPanel(key, index)

  addPanelAfter: (key, otherKey) ->
    index = @getPanelPosition(otherKey)
    @addPanel(key, index + 1)

  removePanel: (key) ->

    panels = @getPanels()

    if _.contains(panels, key)
      panels = _.without(panels, key)

    @clone {
      query: {p: panels.join(',')}
    }

  togglePanel: (key) ->
    if @isPanelActive(key)
      @removePanel(key)
    else
      @addPanel(key)

  isPanelActive: (key) ->
    _.contains(@getPanels(), key)

  getPanelPosition: (key) ->
    @getPanels().indexOf(key)

  movePanelToPosition: (key, index) ->

    panels = _.without(@getPanels(), key)
    panels.splice(index, 0, key)

    @clone {
      query: {p: panels.join(',')}
    }

  toggleSidebar: ->
    @clone {
      query: {s: if @getSidebar() then null else 'y'}
    }

  setScreen: (screen) ->
    @clone {
      screen: screen
    }

  clone: (patch = {}) ->
    currentState = _.pick(this, STATE_PROPS)
    newState = _.merge(currentState, patch)
    return new UrlModel(newState)

  equals: (other) ->
    (this is other) or (@path == other.path)

  makeLinkProps: (props = {}) ->
    _.extend props, {
      to:     @screen
      params: @params
      query:  @query
    }

module.exports = UrlModel
