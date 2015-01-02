_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'common/PropTypes'
CardCommand         = require 'framework/enums/CardCommand'
CardContext         = require '../CardContext'
CommandToggleButton = React.createFactory(require './CommandToggleButton')

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
