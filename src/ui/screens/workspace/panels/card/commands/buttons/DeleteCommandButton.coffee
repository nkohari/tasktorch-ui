_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
CardCommand         = require 'data/enums/CardCommand'
CommandToggleButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/CommandToggleButton')

DeleteCommandButton = React.createClass {

  displayName: 'DeleteCommandButton'

  propTypes:
    card: PropTypes.Card
    
  render: ->
    CommandToggleButton {
      icon:    'trash'
      text:    'Trash'
      command: CardCommand.Delete
    }

}

module.exports = DeleteCommandButton
