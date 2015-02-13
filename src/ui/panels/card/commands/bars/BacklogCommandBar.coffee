_                     = require 'lodash'
React                 = require 'react'
PropTypes             = require 'framework/PropTypes'
CardContext           = require 'ui/panels/card/CardContext'
AcceptCommandButton   = React.createFactory(require 'ui/panels/card/commands/buttons/AcceptCommandButton')
PassCommandButton     = React.createFactory(require 'ui/panels/card/commands/buttons/PassCommandButton')
CompleteCommandButton = React.createFactory(require 'ui/panels/card/commands/buttons/CompleteCommandButton')
DeleteCommandButton   = React.createFactory(require 'ui/panels/card/commands/buttons/DeleteCommandButton')
{div}                 = React.DOM

BacklogCommandBar = React.createClass {

  displayName: 'BacklogCommandBar'

  propTypes:
    card: PropTypes.Card

  mixins: [CardContext]

  render: ->

    div {className: 'backlog commands'},
      div {className: 'button-group'},
        AcceptCommandButton {}
        PassCommandButton {}
      div {className: 'button-group right'},
        CompleteCommandButton {}
        DeleteCommandButton {}

}

module.exports = BacklogCommandBar
