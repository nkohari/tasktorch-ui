_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
CardCommandType     = require 'data/enums/CardCommandType'
CommandToggleButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/CommandToggleButton')

AcceptCommandButton = React.createClass {

  displayName: 'AcceptCommandButton'

  propTypes:
    card: PropTypes.Card

  render: ->

    CommandToggleButton {
      icon:    'accept'
      text:    'Accept'
      command: CardCommandType.Accept
    }

}

module.exports = AcceptCommandButton
