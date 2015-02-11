_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'framework/PropTypes'
CardCommand         = require 'framework/enums/CardCommand'
CardContext         = require 'ui/panels/card/CardContext'
CommandToggleButton = React.createFactory(require 'ui/panels/card/commands/buttons/CommandToggleButton')

CompleteCommandButton = React.createClass {

  displayName: 'CompleteCommandButton'

  mixins: [CardContext]

  render: ->
    CommandToggleButton {
      icon:    'complete'
      text:    'Complete'
      command: CardCommand.Complete
    }

}

module.exports = CompleteCommandButton
