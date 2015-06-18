#--------------------------------------------------------------------------------
React                 = require 'react'
mergeClasses          = require 'common/util/mergeClasses'
PropTypes             = require 'ui/framework/PropTypes'
ShellContext          = require 'ui/framework/mixins/ShellContext'
AcceptCommandButton   = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/AcceptCommandButton')
PassCommandButton     = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/PassCommandButton')
CommentCommandButton  = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/CommentCommandButton')
CompleteCommandButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/CompleteCommandButton')
DeleteCommandButton   = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/DeleteCommandButton')
{div}                 = React.DOM
#--------------------------------------------------------------------------------

InboxCommandBar = React.createClass {

  displayName: 'InboxCommandBar'

  propTypes:
    card: PropTypes.Card

  mixins: [ShellContext]

  render: ->

    if not @props.card.user? or @props.card.user == @getCurrentUser().id
      moveCommands = div {className: 'button-group'},
        AcceptCommandButton {card: @props.card}
        PassCommandButton {card: @props.card}
      completionCommands = div {className: 'button-group right'},
        CompleteCommandButton {card: @props.card}
        DeleteCommandButton {card: @props.card}

    div {className: mergeClasses('queue', @props.className)},
      moveCommands
      div {className: 'button-group'},
        CommentCommandButton {card: @props.card}
      completionCommands

}

module.exports = InboxCommandBar
