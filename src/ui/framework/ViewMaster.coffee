_                = require 'lodash'
EventHandler     = require 'events/framework/EventHandler'
Identity         = require 'ui/framework/Identity'
ViewSpec         = require 'ui/framework/ViewSpec'
LocalStorageSlot = require 'ui/framework/LocalStorageSlot'

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
    'UserLoggedOut'
  ]

  constructor: (eventQueue, @history) ->
    super(eventQueue)
    @slot = new LocalStorageSlot('viewMaster')
    @views = {}
    @screen = undefined
    @identity = undefined
    @loadFromSlot()

  getCurrentScreen: ->
    @screen

  getCurrentView: ->
    @getView(@screen)

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
    @saveToSlot()
    @navigate(screen)

  reset: ->
    @views = {}
    @screen = undefined
    @identity = undefined
    @slot.remove('state')

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
    @setView(@screen, view)

  onUserToggledPanel: (event) ->
    view = @getView(event.panel.screen)
    view.togglePanel(event.panel)
    @setView(event.panel.screen, view)

  onUserMovedPanel: (event) ->
    view = @getCurrentView()
    view.movePanel(event.id, event.newPosition)
    @setView(@screen, view)

  onUserOpenedDrawer: (event) ->
    view = @getCurrentView()
    view.openDrawer()
    @setView(@screen, view)

  onUserClosedDrawer: (event) ->
    view = @getCurrentView()
    view.hideDrawer()
    @setView(@screen, view)

  onUserToggledDrawer: ->
    view = @getCurrentView()
    view.toggleDrawer()
    @setView(@screen, view)

  onUserSelectedScreen: (event) ->
    @navigate(event.screen)

  onUserLoggedOut: ->
    @reset()

  navigate: (screen) ->
    view = @getView(screen ? @screen)
    url  = view.getUrl(@identity, @history)
    @history.pushState(view, url)

  setLocation: (location) ->
    screen = location.pathname.split('/')[2]
    view   = ViewSpec.fromUrl(screen, location.query)
    @views[screen] = view
    @screen = screen
    @saveToSlot()

  setIdentity: (identity) ->
    @identity = identity

  saveToSlot: ->
    @slot.set('state', {@views, @screen, @identity})

  loadFromSlot: ->
    state = @slot.get('state')
    if state?.views? and state?.identity?
      @views = _.object _.map state.views, (view, screen) ->
        [screen, ViewSpec.fromLocalStorage(screen, view)]
      @screen = state.screen
      @identity = new Identity {orgid: state.identity.orgid}

module.exports = ViewMaster
