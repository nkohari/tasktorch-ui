_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
AcceptCommandButton = React.createFactory(require 'ui/panels/card/commands/buttons/AcceptCommandButton')
PassCommandButton   = React.createFactory(require 'ui/panels/card/commands/buttons/PassCommandButton')
DeleteCommandButton = React.createFactory(require 'ui/panels/card/commands/buttons/DeleteCommandButton')
{div}               = React.DOM

DraftsCommandBar = React.createClass {

  displayName: 'DraftsCommandBar'

  propTypes:
    card: PropTypes.Card

  render: ->

    div {className: 'queue commands'},
      div {className: 'button-group'},
        AcceptCommandButton {card: @props.card}
        PassCommandButton {card: @props.card}
      div {className: 'button-group right'},
        DeleteCommandButton {card: @props.card}

}

module.exports = DraftsCommandBar
