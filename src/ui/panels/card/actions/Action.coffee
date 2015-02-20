React               = require 'react'
PropTypes           = require 'framework/PropTypes'
Observe             = require 'framework/mixins/Observe'
Icon                = React.createFactory(require 'ui/common/Icon')
ActionStatus        = React.createFactory(require 'ui/panels/card/actions/ActionStatus')
ActionOwner         = React.createFactory(require 'ui/panels/card/actions/ActionOwner')
ActionText          = React.createFactory(require 'ui/panels/card/actions/ActionText')
ActionDeleteTrigger = React.createFactory(require 'ui/panels/card/actions/ActionDeleteTrigger')
ActionCommandFrame  = React.createFactory(require 'ui/panels/card/actions/ActionCommandFrame')
{div, li, input}    = React.DOM

Action = React.createClass {

  displayName: 'Action'

  propTypes:
    action: PropTypes.Action

  mixins: [Observe()]

  getInitialState: ->
    {command: undefined}

  render: ->

    classes = ['action', @props.action.status.toLowerCase()]

    if @state.command?
      classes.push(@state.command.toLowerCase())
      commandFrame = ActionCommandFrame {
        action:      @props.action
        command:     @state.command
        showCommand: @showCommand
        hideCommand: @hideCommand
      }

    div {className: classes.join(' ')},
      div {},
        ActionStatus {action: @props.action, @showCommand}
        ActionOwner  {action: @props.action, @showCommand}
        ActionText   {action: @props.action}
        div {className: 'action-controls'},
          Icon {name: 'handle'}
          ActionDeleteTrigger {action: @props.action, @showCommand}
      commandFrame

  showCommand: (command) ->
    @setState {command}

  hideCommand: ->
    @setState {command: undefined}

}

module.exports = Action
