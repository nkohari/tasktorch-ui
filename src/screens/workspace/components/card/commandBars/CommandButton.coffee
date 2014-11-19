_                  = require 'lodash'
React              = require 'react/addons'
CardCommandContext = require '../CardCommandContext'
Button             = React.createFactory(require 'common/Button')
{div}              = React.DOM
{classSet}         = React.addons

CommandButton = React.createClass {

  displayName: 'CommandButton'

  mixins: [CardCommandContext]

  propTypes:
    command: React.PropTypes.string.isRequired

  render: ->
    classes = {active: @context.activeCommand == @props.command}
    Button {
      className: classSet(classes)
      icon:      @props.icon
      text:      @props.text
      onClick:   @onButtonClicked
    }

  onButtonClicked: ->
    if @context.activeCommand == @props.command
      @context.hideCommand()
    else
      @context.showCommand(@props.command)

}

module.exports = CommandButton
