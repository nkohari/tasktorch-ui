PropTypes = require 'ui/framework/PropTypes'

CommandContextMaster = {

  childContextTypes:
    activeCommand: PropTypes.string
    showCommand:   PropTypes.func
    hideCommand:   PropTypes.func

  getInitialState: ->
    {activeCommand: undefined}

  getChildContext: ->
    {activeCommand: @state.activeCommand, @showCommand, @hideCommand}

  getActiveCommand: ->
    @state.activeCommand

  hasActiveCommand: ->
    @getActiveCommand()?

  isActiveCommand: (name) ->
    @getActiveCommand() == name

  showCommand: (name) ->
    @setState {activeCommand: name}

  hideCommand: ->
    @setState {activeCommand: undefined}

}

module.exports = CommandContextMaster
