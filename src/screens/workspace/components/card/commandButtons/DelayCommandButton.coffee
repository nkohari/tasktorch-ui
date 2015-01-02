_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'common/PropTypes'
CardCommand         = require 'framework/enums/CardCommand'
CardContext         = require '../CardContext'
CommandToggleButton = React.createFactory(require './CommandToggleButton')

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
