PropTypes = require 'ui/framework/PropTypes'

CommandContextMaster = {

  childContextTypes:
    activeCommand: PropTypes.string
    commandProps:  PropTypes.object
    showCommand:   PropTypes.func
    hideCommand:   PropTypes.func

  getInitialState: ->
    {activeCommand: undefined}

  getChildContext: ->
    {activeCommand: @state.activeCommand, commandProps: @state.commandProps, @showCommand, @hideCommand}

  getActiveCommand: ->
    @state.activeCommand

  getCommandProps: ->
    @state.commandProps ? {}

  hasActiveCommand: ->
    @getActiveCommand()?

  isActiveCommand: (name) ->
    @getActiveCommand() == name

  showCommand: (name, props = {}) ->
    @setState {activeCommand: name, commandProps: props}

  hideCommand: ->
    @setState {activeCommand: undefined, commandProps: undefined}

}

module.exports = CommandContextMaster
