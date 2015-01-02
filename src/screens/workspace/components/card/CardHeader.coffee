_                   = require 'lodash'
React               = require 'react/addons'
PropTypes           = require 'common/PropTypes'
KindDisplayedEvent  = require 'events/display/KindDisplayedEvent'
StackDisplayedEvent = require 'events/display/StackDisplayedEvent'
UserDisplayedEvent  = require 'events/display/UserDisplayedEvent'
Observe             = require 'mixins/Observe'
CardContext         = require './CardContext'
CardCommandBar      = React.createFactory(require './CardCommandBar')
CardTitle           = React.createFactory(require './CardTitle')
CardWidgets         = React.createFactory(require './CardWidgets')
Avatar              = React.createFactory(require 'common/Avatar')
Icon                = React.createFactory(require 'common/Icon')
CSSTransitionGroup  = React.createFactory(React.addons.CSSTransitionGroup)
{div}               = React.DOM
{classSet}          = React.addons

CommandPanels =
  Delay:    React.createFactory(require './commandPanels/DelayCommandPanel')
  Pass:     React.createFactory(require './commandPanels/PassCommandPanel')
  Complete: React.createFactory(require './commandPanels/CompleteCommandPanel')
  Delete:   React.createFactory(require './commandPanels/DeleteCommandPanel')

CardHeader = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardHeader'

  propTypes:
    card: PropTypes.Card
    kind: PropTypes.Kind

  mixins: [
    Observe('stacks', 'users')
    CardContext
  ]

  getInitialState: ->
    {command: undefined}

  # Lifecycle ---------------------------------------------------------------------

  componentWillMount: ->
    @publish new StackDisplayedEvent(@props.card.stack) if @props.card.stack?
    @publish new UserDisplayedEvent(@props.card.owner)  if @props.card.owner?

  componentWillReceiveProps: (newProps) ->
    prev = @props.card
    curr = newProps.card
    @publish new StackDisplayedEvent(curr.stack) if curr.stack? and curr.stack != prev.stack
    @publish new UserDisplayedEvent(curr.owner)  if curr.owner? and curr.owner != prev.owner

  # State -------------------------------------------------------------------------

  sync: (stores) ->
    return {
      stack: stores.stacks.get(@props.card.stack) if @props.card.stack?
      owner: stores.users.get(@props.card.owner)  if @props.card.owner?
    }

  ready: ->
    return {
      stack: (@state.stack? or not @props.card.stack?)
      owner: (@state.owner? or not @props.card.owner?)
    }

  # Rendering ---------------------------------------------------------------------

  render: ->

    classes =
      header:   true
      expanded: @state.command?

    div {
      className: classSet(classes)
      style:     {borderColor: @props.kind.color}
    }, @contents()

  children: ->

    if @state.command?
      command = CommandPanels[@state.command] {key: 'command', card: @props.card, stack: @state.stack}

    return [
      div {key: 'fixed', className: 'fixed'}, [
        @renderOwner()
        div {key: 'info', className: 'info'}, [
          CardTitle   {key: 'title',    card: @props.card}
          CardWidgets {key: 'location', card: @props.card, stack: @state.stack}
        ]
        CardCommandBar {key: 'commands', card: @props.card, stack: @state.stack}
      ]
      CSSTransitionGroup {key: 'flexible', className: 'flexible', component: 'div', transitionName: 'slide'}, [
        command if command?
      ]
    ]

  renderOwner: ->
    if @state.owner?
      Avatar {key: 'owner', className: 'owner', user: @state.owner}
    else
      div {key: 'owner', className: 'team owner'}, [
        Icon {key: 'icon', name: 'team'}
      ]

  # Utility -----------------------------------------------------------------------

  showCommandPanel: (command) ->
    @setState {command: command}

  hideCommandPanel: ->
    @setState {command: undefined}

  #--------------------------------------------------------------------------------

}

module.exports = CardHeader
