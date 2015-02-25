_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
classSet       = require 'common/util/classSet'
CardCommand    = require 'data/enums/CardCommand'
CommandContext = require 'ui/framework/mixins/CommandContext'
Button         = React.createFactory(require 'ui/common/Button')
{div}          = React.DOM

CommandToggleButton = React.createClass {

  displayName: 'CommandToggleButton'

  propTypes:
    command: PropTypes.enum(CardCommand)

  mixins: [CommandContext]

  render: ->

    classes = classSet [
      'active' if @isActiveCommand(@props.command)
    ]

    Button {
      className: classes
      icon: @props.icon
      text: @props.text
      @onClick
    }

  onClick: ->
    @toggleCommand(@props.command)

}

module.exports = CommandToggleButton
