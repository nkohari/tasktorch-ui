_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'ui/framework/PropTypes'
CardCommand         = require 'data/enums/CardCommand'
CommandToggleButton = React.createFactory(require 'ui/panels/card/commands/buttons/CommandToggleButton')

PassCommandButton = React.createClass {

  displayName: 'PassCommandButton'

  propTypes:
    card: PropTypes.Card
    
  render: ->
    CommandToggleButton {
      icon:    'pass'
      text:    'Pass'
      command: CardCommand.Pass
    }

}

module.exports = PassCommandButton
