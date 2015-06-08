React                  = require 'react'
CardCommandType        = require 'data/enums/CardCommandType'
PropTypes              = require 'ui/framework/PropTypes'
CommandContext         = require 'ui/framework/mixins/CommandContext'
AcceptCommandOverlay   = React.createFactory(require 'ui/screens/workspace/panels/card/commands/overlays/AcceptCommandOverlay')
DeferCommandOverlay    = React.createFactory(require 'ui/screens/workspace/panels/card/commands/overlays/DeferCommandOverlay')
PassCommandOverlay     = React.createFactory(require 'ui/screens/workspace/panels/card/commands/overlays/PassCommandOverlay')
CompleteCommandOverlay = React.createFactory(require 'ui/screens/workspace/panels/card/commands/overlays/CompleteCommandOverlay')
DeleteCommandOverlay   = React.createFactory(require 'ui/screens/workspace/panels/card/commands/overlays/DeleteCommandOverlay')
RestoreCommandOverlay  = React.createFactory(require 'ui/screens/workspace/panels/card/commands/overlays/RestoreCommandOverlay')
CommentCommandOverlay  = React.createFactory(require 'ui/screens/workspace/panels/card/commands/overlays/CommentCommandOverlay')
CSSTransitionGroup     = React.createFactory(React.addons.CSSTransitionGroup)
{div}                  = React.DOM

CardCommand = React.createClass {

  displayName: 'CardCommand'

  propTypes:
    card:    PropTypes.Card
    stack:   PropTypes.Stack
    command: PropTypes.enum(CardCommandType)

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
      when CardCommandType.Accept   then AcceptCommandOverlay
      when CardCommandType.Defer    then DeferCommandOverlay
      when CardCommandType.Pass     then PassCommandOverlay
      when CardCommandType.Complete then CompleteCommandOverlay
      when CardCommandType.Delete   then DeleteCommandOverlay
      when CardCommandType.Restore  then RestoreCommandOverlay
      when CardCommandType.Comment  then CommentCommandOverlay

  onBackdropClicked: (event) ->
    if event.target == @refs.backdrop.getDOMNode()
      @hideCommand()

}

module.exports = CardCommand
