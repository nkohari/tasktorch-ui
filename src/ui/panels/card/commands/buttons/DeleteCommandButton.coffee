_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'framework/PropTypes'
CardCommand         = require 'framework/enums/CardCommand'
CardContext         = require 'ui/panels/card/CardContext'
CommandToggleButton = React.createFactory(require 'ui/panels/card/commands/buttons/CommandToggleButton')

DeleteCommandButton = React.createClass {

  displayName: 'DeleteCommandButton'

  mixins: [CardContext]

  render: ->
    CommandToggleButton {
      icon:    'trash'
      text:    'Trash'
      command: CardCommand.Delete
    }

}

module.exports = DeleteCommandButton
