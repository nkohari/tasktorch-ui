_           = require 'lodash'
React       = require 'react/addons'
Button      = React.createFactory(require 'common/Button')
{div}       = React.DOM
{classSet}  = React.addons

CommandButton = React.createClass {

  displayName: 'CommandButton'

  propTypes:
    activeCommand: React.PropTypes.string
    command:       React.PropTypes.string.isRequired
    showCommand:   React.PropTypes.func.isRequired

  render: ->
    classes = {active: @props.activeCommand == @props.command}
    Button {
      className: classSet(classes)
      icon:      @props.icon
      text:      @props.text
      onClick:   @onButtonClicked
    }

  onButtonClicked: ->
    @props.showCommand(@props.command)

}

module.exports = CommandButton
