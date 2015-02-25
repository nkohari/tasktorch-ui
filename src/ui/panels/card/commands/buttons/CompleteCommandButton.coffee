_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
CardCommand         = require 'data/enums/CardCommand'
CommandToggleButton = React.createFactory(require 'ui/panels/card/commands/buttons/CommandToggleButton')

CompleteCommandButton = React.createClass {

  displayName: 'CompleteCommandButton'

  propTypes:
    card: PropTypes.Card

  render: ->

    CommandToggleButton {
      icon:    'complete'
      text:    'Complete'
      command: CardCommand.Complete
    }

}

module.exports = CompleteCommandButton
