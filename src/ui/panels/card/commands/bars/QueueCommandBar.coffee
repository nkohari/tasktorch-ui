_                     = require 'lodash'
React                 = require 'react'
PropTypes             = require 'ui/framework/PropTypes'
PassCommandButton     = React.createFactory(require 'ui/panels/card/commands/buttons/PassCommandButton')
DeferCommandButton    = React.createFactory(require 'ui/panels/card/commands/buttons/DeferCommandButton')
CompleteCommandButton = React.createFactory(require 'ui/panels/card/commands/buttons/CompleteCommandButton')
DeleteCommandButton   = React.createFactory(require 'ui/panels/card/commands/buttons/DeleteCommandButton')
{div}                 = React.DOM

QueueCommandBar = React.createClass {

  displayName: 'QueueCommandBar'

  propTypes:
    card: PropTypes.Card
    
  render: ->

    div {className: 'queue commands'},
      div {className: 'button-group'},
        PassCommandButton {card: @props.card}
        DeferCommandButton {card: @props.card}
      div {className: 'button-group right'},
        CompleteCommandButton {card: @props.card}
        DeleteCommandButton {card: @props.card}

}

module.exports = QueueCommandBar
