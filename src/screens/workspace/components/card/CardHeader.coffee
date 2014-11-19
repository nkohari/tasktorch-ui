_                  = require 'lodash'
React              = require 'react'
Observe            = require 'mixins/Observe'
CardCommandContext = require './CardCommandContext'
CardTitle          = React.createFactory(require './CardTitle')
CardWidgets        = React.createFactory(require './CardWidgets')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM

CommandBars =
  Inbox:   React.createFactory(require './commandBars/InboxCommandBar')
  Queue:   React.createFactory(require './commandBars/QueueCommandBar')
  Backlog: React.createFactory(require './commandBars/BacklogCommandBar')

CommandPanels =
  Defer:   React.createFactory(require './commandPanels/DeferCommandPanel')
  HandOff: React.createFactory(require './commandPanels/HandOffCommandPanel')

CardHeader = React.createClass {

  displayName: 'CardHeader'

  mixins: [Observe(), CardCommandContext]

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
      style:     {borderColor: @props.kind.color}
    }, [
      div {key: 'fixed', className: 'fixed'}, [
        CardTitle {key: 'title', card: @props.card}
        CardWidgets {key: 'location', card: @props.card, stack: @props.stack}
        CommandBar {key: 'commands', card: @props.card}
      ]
      CSSTransitionGroup {key: 'flexible', className: 'flexible', component: 'div', transitionName: 'command-slide'}, [
        CommandPanel {key: 'command', card: @props.card, stack: @props.stack} if @state.command?
      ]
    ]

  showCommand: (command) ->
    @setState {command: command}

  hideCommand: ->
    @setState {command: undefined}

}

module.exports = CardHeader
