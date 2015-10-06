PropTypes = require 'ui/framework/PropTypes'

PanelContext = {

  contextTypes:
    currentPanel: PropTypes.object

  getCurrentPanel: ->
    @context.currentPanel

}

module.exports = PanelContext
