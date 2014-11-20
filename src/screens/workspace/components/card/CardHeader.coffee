_                  = require 'lodash'
React              = require 'react/addons'
Observe            = require 'mixins/Observe'
CardCommandContext = require './CardCommandContext'
CardTitle          = React.createFactory(require './CardTitle')
CardWidgets        = React.createFactory(require './CardWidgets')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM
{classSet}         = React.addons

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

    classes =
      header:   true
      expanded: @state.command?

    if @state.command?
      command = CommandPanels[@state.command] {key: 'command', card: @props.card, stack: @props.stack}

    div {
      className: classSet(classes)
      style:     {borderColor: @props.kind.color}
    }, [
      div {key: 'fixed', className: 'fixed'}, [
        CardTitle {key: 'title', card: @props.card}
        CardWidgets {key: 'location', card: @props.card, stack: @props.stack}
        CommandBars[@props.stack.type] {key: 'commands', card: @props.card}
      ]
      CSSTransitionGroup {key: 'flexible', className: 'flexible', component: 'div', transitionName: 'slide'}, [
        command if command?
      ]
    ]

  showCommand: (command) ->
    @setState {command: command}

  hideCommand: ->
    @setState {command: undefined}

}

module.exports = CardHeader
