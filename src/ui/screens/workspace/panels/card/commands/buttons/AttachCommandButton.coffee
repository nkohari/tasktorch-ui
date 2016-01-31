#--------------------------------------------------------------------------------
_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
CardCommandType     = require 'data/enums/CardCommandType'
CommandToggleButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/CommandToggleButton')
#--------------------------------------------------------------------------------

AttachCommandButton = React.createClass {

  displayName: 'AttachCommandButton'

  propTypes:
    card: PropTypes.Card

  render: ->

    CommandToggleButton {
      icon:    'file'
      text:    'Attach'
      command: CardCommandType.Attach
    }

}

module.exports = AttachCommandButton
