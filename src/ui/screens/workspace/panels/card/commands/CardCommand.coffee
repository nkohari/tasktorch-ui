React                  = require 'react'
CardCommand            = require 'data/enums/CardCommand'
PropTypes              = require 'ui/framework/PropTypes'
CommandContext         = require 'ui/framework/mixins/CommandContext'
DeferCommandOverlay    = React.createFactory(require 'ui/screens/workspace/panels/card/commands/overlays/DeferCommandOverlay')
PassCommandOverlay     = React.createFactory(require 'ui/screens/workspace/panels/card/commands/overlays/PassCommandOverlay')
CompleteCommandOverlay = React.createFactory(require 'ui/screens/workspace/panels/card/commands/overlays/CompleteCommandOverlay')
DeleteCommandOverlay   = React.createFactory(require 'ui/screens/workspace/panels/card/commands/overlays/DeleteCommandOverlay')
CSSTransitionGroup     = React.createFactory(React.addons.CSSTransitionGroup)
{div}                  = React.DOM

CardCommandOverlay = React.createClass {

  displayName: 'CardCommandOverlay'

  propTypes:
    card:    PropTypes.Card
    stack:   PropTypes.Stack
    command: PropTypes.enum(CardCommand)

  render: ->

    if @props.command?
      CommandOverlay = @getCommandOverlayClass()
      command = div {className: 'command-backdrop'},
        CommandOverlay {card: @props.card, stack: @props.stack}

    CSSTransitionGroup {className: 'command-placeholder', component: 'div', transitionName: 'slide'},
      command

  getCommandOverlayClass: ->
    switch @props.command
      when CardCommand.Defer    then DeferCommandOverlay
      when CardCommand.Pass     then PassCommandOverlay
      when CardCommand.Complete then CompleteCommandOverlay
      when CardCommand.Delete   then DeleteCommandOverlay

}

module.exports = CardCommandOverlay
