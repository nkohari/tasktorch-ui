_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'framework/PropTypes'
CardCommand         = require 'framework/enums/CardCommand'
CardContext         = require 'ui/panels/card/CardContext'
CommandToggleButton = React.createFactory(require 'ui/panels/card/commands/buttons/CommandToggleButton')

DelayCommandButton = React.createClass {

  displayName: 'DelayCommandButton'

  mixins: [CardContext]

  render: ->
    CommandToggleButton {
      icon:    'delay'
      text:    'Delay'
      command: CardCommand.Delay
    }

}

module.exports = DelayCommandButton
