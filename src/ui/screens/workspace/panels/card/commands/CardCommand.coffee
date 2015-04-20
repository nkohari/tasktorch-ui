React                  = require 'react'
CardCommand            = require 'data/enums/CardCommand'
PropTypes              = require 'ui/framework/PropTypes'
CommandContext         = require 'ui/framework/mixins/CommandContext'
AcceptCommandOverlay   = React.createFactory(require 'ui/screens/workspace/panels/card/commands/overlays/AcceptCommandOverlay')
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

  mixins: [CommandContext]

  render: ->

    if @props.command?
      CommandOverlay = @getCommandOverlayClass()
      command = div {ref: 'backdrop', key: @props.command, className: 'command-backdrop', onClick: @onBackdropClicked},
        CommandOverlay {card: @props.card, stack: @props.stack}

    CSSTransitionGroup {className: 'command-placeholder', component: 'div', transitionName: 'slide'},
      command

  getCommandOverlayClass: ->
    switch @props.command
      when CardCommand.Accept   then AcceptCommandOverlay
      when CardCommand.Defer    then DeferCommandOverlay
      when CardCommand.Pass     then PassCommandOverlay
      when CardCommand.Complete then CompleteCommandOverlay
      when CardCommand.Delete   then DeleteCommandOverlay

  onBackdropClicked: (event) ->
    if event.target == @refs.backdrop.getDOMNode()
      @hideCommand()

}

module.exports = CardCommandOverlay
