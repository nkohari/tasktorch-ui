_                    = require 'lodash'
React                = require 'react'
PropTypes            = require 'ui/framework/PropTypes'
RestoreCommandButton = React.createFactory(require 'ui/panels/card/commands/buttons/RestoreCommandButton')
{div}                = React.DOM

TrashCommandBar = React.createClass {

  displayName: 'TrashCommandBar'

  propTypes:
    card: PropTypes.Card

  render: ->

    div {className: 'archive commands'},
      div {className: 'button-group'},
        RestoreCommandButton {card: @props.card}

}

module.exports = TrashCommandBar
