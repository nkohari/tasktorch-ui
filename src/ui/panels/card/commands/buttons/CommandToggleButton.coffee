_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'framework/PropTypes'
classSet    = require 'framework/util/classSet'
CardCommand = require 'framework/enums/CardCommand'
CardContext = require 'ui/panels/card/CardContext'
Button      = React.createFactory(require 'ui/common/Button')
{div}       = React.DOM

CommandToggleButton = React.createClass {

  displayName: 'CommandToggleButton'

  propTypes:
    command: PropTypes.enum(CardCommand)

  mixins: [CardContext]

  render: ->
    Button {
      className: classSet {active: @isActiveCommand(@props.command)}
      icon:      @props.icon
      text:      @props.text
      onClick:   @onButtonClicked
    }

  onButtonClicked: ->
    if @isActiveCommand(@props.command)
      @context.hideCommandPanel(@props.command)
    else
      @context.showCommandPanel(@props.command)

}

module.exports = CommandToggleButton
