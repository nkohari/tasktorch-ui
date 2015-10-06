_            = require 'lodash'
EventHandler = require 'events/framework/EventHandler'
ViewSpec     = require 'ui/framework/ViewSpec'

class ViewMaster extends EventHandler

  displayName: 'ViewMaster'

  listensFor: [
    'UserOpenedPanel'
    'UserClosedPanel'
    'UserMovedPanel'
    'UserToggledPanel'
    'UserOpenedDrawer'
    'UserClosedDrawer'
    'UserToggledDrawer'
    'UserSelectedScreen'
  ]

  constructor: (eventQueue, @history) ->
    super(eventQueue)
    @views = {}
    @identity = undefined

  getCurrentView: ->
    @getView(@currentScreen)

  getIdentity: ->
    @identity

  getView: (screen) ->
    view = @views[screen]
    unless view?
      view = @views[screen] = new ViewSpec(screen)
    return view

  setView: (screen, view) ->
    @views[screen] = view
    debug.log("ViewMaster: #{screen} view is now %o", view)
    @navigate(screen)

  reset: ->
    @views = {}

  onUserOpenedPanel: (event) ->
    {panel, options} = event
    view = @getView(panel.screen)
    if options.before?
      view.addPanelBefore(panel, options.before)
    else if options.after?
      view.addPanelAfter(panel, options.after)
    else
      view.addPanel(panel)
    @setView(panel.screen, view)

  onUserClosedPanel: (event) ->
    view = @getCurrentView()
    view.removePanel(event.id)
    @setView(@currentScreen, view)

  onUserToggledPanel: (event) ->
    view = @getView(event.panel.screen)
    view.togglePanel(event.panel)
    @setView(event.panel.screen, view)

  onUserMovedPanel: (event) ->
    view = @getCurrentView()
    view.movePanel(event.id, event.newPosition)
    @setView(@currentScreen, view)

  onUserOpenedDrawer: (event) ->
    view = @getCurrentView()
    view.openDrawer()
    @setView(@currentScreen, view)

  onUserClosedDrawer: (event) ->
    view = @getCurrentView()
    view.hideDrawer()
    @setView(@currentScreen, view)

  onUserToggledDrawer: ->
    view = @getCurrentView()
    view.toggleDrawer()
    @setView(@currentScreen, view)

  onUserSelectedScreen: (event) ->
    @navigate(event.screen)

  navigate: (screen) ->
    view = @getView(screen)
    url  = view.getUrl(@identity, @history)
    @history.pushState(view, url)

  setLocation: (location) ->
    screen = location.pathname.split('/')[2]
    view = new ViewSpec(screen, location.query)
    @views[screen] = view
    @currentScreen = screen

  setIdentity: (identity) ->
    @identity = identity

module.exports = ViewMaster
