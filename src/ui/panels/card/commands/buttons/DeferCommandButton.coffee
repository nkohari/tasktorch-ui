_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'framework/PropTypes'
CardCommand         = require 'framework/enums/CardCommand'
CardContext         = require 'ui/panels/card/CardContext'
CommandToggleButton = React.createFactory(require 'ui/panels/card/commands/buttons/CommandToggleButton')

DeferCommandButton = React.createClass {

  displayName: 'DeferCommandButton'

  mixins: [CardContext]

  render: ->
    CommandToggleButton {
      icon:    'defer'
      text:    'Defer'
      command: CardCommand.Defer
    }

}

module.exports = DeferCommandButton
