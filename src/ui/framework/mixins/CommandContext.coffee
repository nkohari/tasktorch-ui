PropTypes = require 'ui/framework/PropTypes'

CommandContext = {

  contextTypes:
    activeCommand: PropTypes.string
    commandProps:  PropTypes.object
    showCommand:   PropTypes.func
    hideCommand:   PropTypes.func

  getActiveCommand: ->
    @context.activeCommand

  getCommandProps: ->
    @context.commandProps ? {}

  isActiveCommand: (name) ->
    @getActiveCommand() == name

  hasActiveCommand: ->
    @getActiveCommand()?

  showCommand: (name) ->
    @context.showCommand(name)

  hideCommand: (name) ->
    @context.hideCommand(name)

  toggleCommand: (name) ->
    if @isActiveCommand(name)
      @context.hideCommand(name)
    else
      @context.showCommand(name)

}

module.exports = CommandContext
