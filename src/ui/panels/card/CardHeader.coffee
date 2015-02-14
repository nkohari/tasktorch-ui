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
CardOwner           = React.createFactory(require 'ui/common/CardOwner')
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

  componentDidMount: ->
    @publish new StackDisplayedEvent(@props.card.stack) if @props.card.stack?
    @publish new UserDisplayedEvent(@props.card.owner)  if @props.card.owner?

  componentWillReceiveProps: (newProps) ->
    prev = @props.card
    curr = newProps.card
    @publish new StackDisplayedEvent(curr.stack) if curr.stack? and curr.stack != prev.stack
    @publish new UserDisplayedEvent(curr.owner)  if curr.owner? and curr.owner != prev.owner

  sync: (stores) ->
    return {
      stack: stores.stacks.get(@props.card.stack) if @props.card.stack?
      owner: stores.users.get(@props.card.owner)  if @props.card.owner?
    }

  isReady: ->
    (@state.stack? or not @props.card.stack?) and (@state.owner? or not @props.card.owner?)

  render: ->

    classes = ['header']
    classes.push('expanded') if @state.command?

    style = {borderColor: @props.kind.color}

    Frame {@isReady, className: classes.join(' '), style},
      div {className: 'fixed'},
        CardOwner {user: @state.owner}
        div {className: 'info'},
          CardTitle   {card: @props.card}
          CardWidgets {card: @props.card, stack: @state.stack}
        CardCommandBar {card: @props.card, stack: @state.stack}
      @renderCommand()

  renderCommand: ->

    CSSTransitionGroup {className: 'flexible', component: 'div', transitionName: 'slide'},
      CommandPanels[@state.command] {card: @props.card, stack: @state.stack} if @state.command?

  showCommandPanel: (command) ->
    @setState {command: command}

  hideCommandPanel: ->
    @setState {command: undefined}

}

module.exports = CardHeader
