_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
CardCommand         = require 'data/enums/CardCommand'
CommandToggleButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/CommandToggleButton')

AcceptCommandButton = React.createClass {

  displayName: 'AcceptCommandButton'

  propTypes:
    card: PropTypes.Card

  render: ->

    CommandToggleButton {
      icon:    'accept'
      text:    'Accept'
      command: CardCommand.Accept
    }

}

module.exports = AcceptCommandButton
