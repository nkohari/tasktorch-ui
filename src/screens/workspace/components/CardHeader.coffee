_                  = require 'lodash'
React              = require 'react'
Observe            = require 'mixins/Observe'
CardTitle          = React.createFactory(require './CardTitle')
CardWidgets        = React.createFactory(require './CardWidgets')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM

CommandBars =
  Inbox:   React.createFactory(require './commands/InboxCommandBar')
  Queue:   React.createFactory(require './commands/QueueCommandBar')
  Backlog: React.createFactory(require './commands/BacklogCommandBar')

CommandPanels =
  Defer:   React.createFactory(require './commands/DeferCommandPanel')
  HandOff: React.createFactory(require './commands/HandOffCommandPanel')

CardHeader = React.createClass {

  displayName: 'CardHeader'

  mixins: [Observe()]

  propTypes:
    card: React.PropTypes.object.isRequired
    stack: React.PropTypes.object.isRequired

  getInitialState: ->
    {command: undefined}

  render: ->

    CommandBar   = CommandBars[@props.stack.type]
    CommandPanel = CommandPanels[@state.command] if @state.command?

    div {
      className: 'header'
      style:     {borderLeftColor: @props.kind.color}
    }, [
      div {key: 'fixed', className: 'fixed'}, [
        CardTitle {key: 'title', card: @props.card}
        CardWidgets {key: 'location', card: @props.card, stack: @props.stack}
        CommandBar {key: 'commands', card: @props.card, activeCommand: @state.command, @showCommand}
      ]
      CSSTransitionGroup {key: 'flexible', className: 'flexible', component: 'div', transitionName: 'command-slide'}, [
        CommandPanel {key: 'command', card: @props.card, stack: @props.stack, @hideCommand} if @state.command?
      ]
    ]

  showCommand: (command) ->
    @setState {command: command}

  hideCommand: ->
    @setState {command: undefined}

}

module.exports = CardHeader
