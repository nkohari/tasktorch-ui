_         = require 'lodash'
Keymaster = require 'keymaster'
React     = require 'react'
Icon      = React.createFactory(require 'ui/common/Icon')
{span, button} = React.DOM

Button = React.createClass {

  displayName: 'Button'

  componentDidMount: ->
    Keymaster(@props.hotkey, @onHotkeyPressed) if @props.hotkey?

  componentWillUnmount: ->
    Keymaster.unbind(@props.hotkey) if @props.hotkey?

  render: ->
    props = _.omit(@props, 'icon', 'text')
    button props,
      Icon {name: @props.icon} if @props.icon?
      span {}, @props.text

  onHotkeyPressed: ->
    return unless @isMounted()
    @getDOMNode().click()

}

module.exports = Button
