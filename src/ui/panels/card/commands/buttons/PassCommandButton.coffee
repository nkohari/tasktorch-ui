_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'framework/PropTypes'
CardCommand         = require 'framework/enums/CardCommand'
CardContext         = require 'ui/panels/card/CardContext'
CommandToggleButton = React.createFactory(require 'ui/panels/card/commands/buttons/CommandToggleButton')

PassCommandButton = React.createClass {

  displayName: 'PassCommandButton'

  mixins: [CardContext]

  render: ->
    CommandToggleButton {
      icon:    'pass'
      text:    'Pass'
      command: CardCommand.Pass
    }

}

module.exports = PassCommandButton
