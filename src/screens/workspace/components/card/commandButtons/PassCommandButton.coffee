_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'common/PropTypes'
CardCommand         = require 'framework/enums/CardCommand'
CardContext         = require '../CardContext'
CommandToggleButton = React.createFactory(require './CommandToggleButton')

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
