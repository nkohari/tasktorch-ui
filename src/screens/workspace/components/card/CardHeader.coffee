_                   = require 'lodash'
React               = require 'react/addons'
PropTypes           = require 'common/PropTypes'
KindDisplayedEvent  = require 'events/display/KindDisplayedEvent'
StackDisplayedEvent = require 'events/display/StackDisplayedEvent'
UserDisplayedEvent  = require 'events/display/UserDisplayedEvent'
Observe             = require 'mixins/Observe'
CardCommandContext  = require './CardCommandContext'
CardTitle           = React.createFactory(require './CardTitle')
CardWidgets         = React.createFactory(require './CardWidgets')
Avatar              = React.createFactory(require 'common/Avatar')
CSSTransitionGroup  = React.createFactory(React.addons.CSSTransitionGroup)
{div}               = React.DOM
{classSet}          = React.addons

CommandBars =
  Queue:   React.createFactory(require './commandBars/QueueCommandBar')
  Inbox:   React.createFactory(require './commandBars/InboxCommandBar')
  Drafts:  React.createFactory(require './commandBars/DraftsCommandBar')
  Backlog: React.createFactory(require './commandBars/BacklogCommandBar')

CommandPanels =
  Defer:   React.createFactory(require './commandPanels/DeferCommandPanel')
  HandOff: React.createFactory(require './commandPanels/HandOffCommandPanel')

CardHeader = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardHeader'

  propTypes:
    card: PropTypes.Card.isRequired
    kind: PropTypes.Kind.isRequired

  mixins: [
    Observe('stacks', 'users')
    CardCommandContext
  ]

  getInitialState: ->
    {command: undefined}

  # Lifecycle ---------------------------------------------------------------------

  componentWillMount: ->
    @publish new StackDisplayedEvent(@props.card.stack)
    @publish new UserDisplayedEvent(@props.card.owner) if @props.card.owner?

  componentWillReceiveProps: (newProps) ->
    @publish new StackDisplayedEvent(newProps.card.stack) if newProps.card.stack != @props.card.stack
    @publish new UserDisplayedEvent(newProps.card.owner)  if newProps.card.owner != @props.card.owner

  # State -------------------------------------------------------------------------

  sync: (stores) ->
    return {
      stack: stores.stacks.get(@props.card.stack)
      owner: stores.users.get(@props.card.owner) if @props.card.owner?
    }

  ready: ->
    return {
      stack: @state.stack?
      owner: (@state.owner? or not @props.card.owner)
    }

  # Rendering ---------------------------------------------------------------------

  render: ->

    classes =
      header:   true
      expanded: @state.command?

    div {
      className: classSet(classes)
      style:     {borderColor: @props.kind.color}
    }, @renderChildrenIfReady()

  children: ->

    if @state.command?
      command = CommandPanels[@state.command] {key: 'command', card: @props.card, stack: @state.stack}

    return [
      div {key: 'fixed', className: 'fixed'}, [
        Avatar {key: 'owner', className: 'owner', user: @state.owner}
        div {key: 'info', className: 'info'}, [
          CardTitle {key: 'title', card: @props.card}
          CardWidgets {key: 'location', card: @props.card, stack: @state.stack}
        ]
        CommandBars[@state.stack.type] {key: 'commands', card: @props.card}
      ]
      CSSTransitionGroup {key: 'flexible', className: 'flexible', component: 'div', transitionName: 'slide'}, [
        command if command?
      ]
    ]

  # Utility -----------------------------------------------------------------------

  showCommand: (command) ->
    @setState {command: command}

  hideCommand: ->
    @setState {command: undefined}

  #--------------------------------------------------------------------------------

}

module.exports = CardHeader
