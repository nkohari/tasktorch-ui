#--------------------------------------------------------------------------------
_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
CardCommandType     = require 'data/enums/CardCommandType'
CommandToggleButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/CommandToggleButton')
#--------------------------------------------------------------------------------

CompleteCommandButton = React.createClass {

  displayName: 'CompleteCommandButton'

  propTypes:
    card: PropTypes.Card

  render: ->

    CommandToggleButton {
      icon:    'complete'
      command: CardCommandType.Complete
    }

}

module.exports = CompleteCommandButton
