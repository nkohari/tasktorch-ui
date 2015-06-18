#--------------------------------------------------------------------------------
_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
CardCommandType     = require 'data/enums/CardCommandType'
CommandToggleButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/CommandToggleButton')
#--------------------------------------------------------------------------------

DeleteCommandButton = React.createClass {

  displayName: 'DeleteCommandButton'

  propTypes:
    card: PropTypes.Card
    
  render: ->
    CommandToggleButton {
      icon:    'trash'
      command: CardCommandType.Delete
    }

}

module.exports = DeleteCommandButton
