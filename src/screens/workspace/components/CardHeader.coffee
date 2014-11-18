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

    header = div {
      className: 'header'
      style:     {borderLeftColor: @props.kind.color}
    }, [
      CardTitle {key: 'title', card: @props.card}
      CardWidgets {key: 'location', card: @props.card, stack: @props.stack}
      CommandBars[@props.stack.type] {key: 'commands', card: @props.card, @showCommandPanel}
    ]

    if @state.command?
      command = CommandPanels[@state.command] {key: 'command', card: @props.card, stack: @props.stack, @hideCommandPanel}

    div {className: 'top'}, _.compact [
      header
      CSSTransitionGroup {key: 'command', className: 'command-frame', component: 'div', transitionName: 'command-slide'}, [
        command if command?
      ]
    ]

  showCommandPanel: (command) ->
    @setState {command}

  hideCommandPanel: ->
    @setState {command: undefined}

}

module.exports = CardHeader
