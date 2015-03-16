_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
CardCommand         = require 'data/enums/CardCommand'
CommandToggleButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/CommandToggleButton')

DeferCommandButton = React.createClass {

  displayName: 'DeferCommandButton'

  propTypes:
    card: PropTypes.Card
    
  render: ->
    CommandToggleButton {
      icon:    'defer'
      text:    'Defer'
      command: CardCommand.Defer
    }

}

module.exports = DeferCommandButton
