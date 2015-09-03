#--------------------------------------------------------------------------------
_               = require 'lodash'
React           = require 'react'
PropTypes       = require 'ui/framework/PropTypes'
classSet        = require 'common/util/classSet'
CardCommandType = require 'data/enums/CardCommandType'
CommandContext  = require 'ui/framework/mixins/CommandContext'
Button          = React.createFactory(require 'ui/common/Button')
{div}           = React.DOM
#--------------------------------------------------------------------------------

CommandToggleButton = React.createClass {

  displayName: 'CommandToggleButton'

  propTypes:
    command: PropTypes.enum(CardCommandType)

  mixins: [CommandContext]

  render: ->

    classes = classSet [
      "command-toggle-#{@props.command.toLowerCase()}"
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
