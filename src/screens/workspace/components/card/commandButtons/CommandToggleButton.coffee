_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'common/PropTypes'
classSet    = require 'common/util/classSet'
CardCommand = require 'framework/enums/CardCommand'
CardContext = require '../CardContext'
Button      = React.createFactory(require 'common/Button')
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
