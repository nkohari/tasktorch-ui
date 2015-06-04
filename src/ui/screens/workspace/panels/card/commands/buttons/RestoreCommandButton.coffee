_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
CardCommandType     = require 'data/enums/CardCommandType'
CommandToggleButton = React.createFactory(require 'ui/screens/workspace/panels/card/commands/buttons/CommandToggleButton')

RestoreCommandButton = React.createClass {

  displayName: 'RestoreCommandButton'

  propTypes:
    card: PropTypes.Card

  render: ->

    CommandToggleButton {
      icon:    'restore'
      text:    'Restore'
      command: CardCommandType.Restore
    }

}

module.exports = RestoreCommandButton
