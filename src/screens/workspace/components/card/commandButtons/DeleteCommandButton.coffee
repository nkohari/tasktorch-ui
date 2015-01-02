_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'common/PropTypes'
CardCommand         = require 'framework/enums/CardCommand'
CardContext         = require '../CardContext'
CommandToggleButton = React.createFactory(require './CommandToggleButton')

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
