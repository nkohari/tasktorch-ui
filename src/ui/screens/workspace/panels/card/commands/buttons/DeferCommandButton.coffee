#--------------------------------------------------------------------------------
_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
CardCommandType     = require 'data/enums/CardCommandType'
CommandToggleButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/CommandToggleButton')
#--------------------------------------------------------------------------------

DeferCommandButton = React.createClass {

  displayName: 'DeferCommandButton'

  propTypes:
    card: PropTypes.Card
    
  render: ->
    CommandToggleButton {
      icon:    'defer'
      text:    'Defer'
      command: CardCommandType.Defer
    }

}

module.exports = DeferCommandButton
