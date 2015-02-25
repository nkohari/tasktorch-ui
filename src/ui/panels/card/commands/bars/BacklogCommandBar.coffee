_                     = require 'lodash'
React                 = require 'react'
PropTypes             = require 'ui/framework/PropTypes'
AcceptCommandButton   = React.createFactory(require 'ui/panels/card/commands/buttons/AcceptCommandButton')
PassCommandButton     = React.createFactory(require 'ui/panels/card/commands/buttons/PassCommandButton')
CompleteCommandButton = React.createFactory(require 'ui/panels/card/commands/buttons/CompleteCommandButton')
DeleteCommandButton   = React.createFactory(require 'ui/panels/card/commands/buttons/DeleteCommandButton')
{div}                 = React.DOM

BacklogCommandBar = React.createClass {

  displayName: 'BacklogCommandBar'

  propTypes:
    card: PropTypes.Card

  render: ->

    div {className: 'backlog commands'},
      div {className: 'button-group'},
        AcceptCommandButton {card: @props.card}
        PassCommandButton {card: @props.card}
      div {className: 'button-group right'},
        CompleteCommandButton {card: @props.card}
        DeleteCommandButton {card: @props.card}

}

module.exports = BacklogCommandBar
