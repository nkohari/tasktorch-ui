_                   = require 'lodash'
React               = require 'react/addons'
PropTypes           = require 'framework/PropTypes'
KindDisplayedEvent  = require 'events/display/KindDisplayedEvent'
StackDisplayedEvent = require 'events/display/StackDisplayedEvent'
UserDisplayedEvent  = require 'events/display/UserDisplayedEvent'
Observe             = require 'framework/mixins/Observe'
CardContext         = require './CardContext'
Avatar              = React.createFactory(require 'ui/common/Avatar')
Frame               = React.createFactory(require 'ui/common/Frame')
Icon                = React.createFactory(require 'ui/common/Icon')
CardCommandBar      = React.createFactory(require 'ui/panels/card/CardCommandBar')
CardTitle           = React.createFactory(require 'ui/panels/card/CardTitle')
CardWidgets         = React.createFactory(require 'ui/panels/card/CardWidgets')
CSSTransitionGroup  = React.createFactory(React.addons.CSSTransitionGroup)
{div}               = React.DOM

CommandPanels =
  Delay:    React.createFactory(require 'ui/panels/card/commands/panels/DelayCommandPanel')
  Pass:     React.createFactory(require 'ui/panels/card/commands/panels/PassCommandPanel')
  Complete: React.createFactory(require 'ui/panels/card/commands/panels/CompleteCommandPanel')
  Delete:   React.createFactory(require 'ui/panels/card/commands/panels/DeleteCommandPanel')

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

  componentDidMount: ->
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

  isReady: ->
    (@state.stack? or not @props.card.stack?) and (@state.owner? or not @props.card.owner?)

  # Rendering ---------------------------------------------------------------------

  render: ->

    classes = ['header']
    classes.push('expanded') if @state.command?

    Frame {
      @isReady
      className: classes.join(' ')
      style:     {borderColor: @props.kind.color}
    }, [
      div {key: 'fixed', className: 'fixed'}, [
        @renderOwner()
        div {key: 'info', className: 'info'}, [
          CardTitle   {key: 'title',    card: @props.card}
          CardWidgets {key: 'location', card: @props.card, stack: @state.stack}
        ]
        CardCommandBar {key: 'commands', card: @props.card, stack: @state.stack}
      ]
      @renderCommand()
    ]

  renderOwner: ->

    if @state.owner?
      Avatar {key: 'owner', className: 'owner', user: @state.owner}
    else
      div {key: 'owner', className: 'team owner'}, [
        Icon {key: 'icon', name: 'team'}
      ]

  renderCommand: ->

    if @state.command?
      command = CommandPanels[@state.command] {key: 'command', card: @props.card, stack: @state.stack}

    CSSTransitionGroup {key: 'flexible', className: 'flexible', component: 'div', transitionName: 'slide'}, [
      command if command?
    ]

  # Utility -----------------------------------------------------------------------

  showCommandPanel: (command) ->
    @setState {command: command}

  hideCommandPanel: ->
    @setState {command: undefined}

  #--------------------------------------------------------------------------------

}

module.exports = CardHeader
