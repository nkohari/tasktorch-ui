#--------------------------------------------------------------------------------
_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
CardCommandType     = require 'data/enums/CardCommandType'
CommandToggleButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/CommandToggleButton')
#--------------------------------------------------------------------------------

PassCommandButton = React.createClass {

  displayName: 'PassCommandButton'

  propTypes:
    card: PropTypes.Card
    
  render: ->
    CommandToggleButton {
      icon:    'pass'
      text:    'Pass'
      command: CardCommandType.Pass
    }

}

module.exports = PassCommandButton
