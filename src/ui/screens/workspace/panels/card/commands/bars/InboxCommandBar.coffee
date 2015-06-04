React                 = require 'react'
mergeClasses          = require 'common/util/mergeClasses'
PropTypes             = require 'ui/framework/PropTypes'
AcceptCommandButton   = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/AcceptCommandButton')
PassCommandButton     = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/PassCommandButton')
CompleteCommandButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/CompleteCommandButton')
DeleteCommandButton   = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/DeleteCommandButton')
{div}                 = React.DOM

InboxCommandBar = React.createClass {

  displayName: 'InboxCommandBar'

  propTypes:
    card: PropTypes.Card

  render: ->

    div {className: mergeClasses('inbox', @props.className)},
      div {className: 'button-group'},
        AcceptCommandButton {card: @props.card}
        PassCommandButton {card: @props.card}
      div {className: 'button-group right'},
        CompleteCommandButton {card: @props.card}
        DeleteCommandButton {card: @props.card}

}

module.exports = InboxCommandBar
