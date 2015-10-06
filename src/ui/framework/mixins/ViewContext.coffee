PropTypes = require 'ui/framework/PropTypes'

ViewContext = {

  contextTypes:
    currentView: PropTypes.object

  getCurrentScreen: ->
    @context.currentView.screen

  getOpenPanels: ->
    @context.currentView.getOpenPanels()

  isPanelOpen: (id) ->
    @context.currentView.isPanelOpen(id)

  isDrawerOpen: ->
    @context.currentView.isDrawerOpen()

}

module.exports = ViewContext
