PropTypes = require 'ui/framework/PropTypes'

Navigator = {

  contextTypes:
    currentScreen: PropTypes.string
    screenState:   PropTypes.object

  getCurrentScreen: ->
    @getScreen(@context.currentScreen)

  getScreen: (name) ->
    @context.screenState[name]

}

module.exports = Navigator
