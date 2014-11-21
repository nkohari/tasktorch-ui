_         = require 'lodash'
Keymaster = require 'keymaster'
React     = require 'react'
Icon      = React.createFactory(require './Icon')
{span, button} = React.DOM

Button = React.createClass {

  displayName: 'Button'

  componentWillMount: ->
    Keymaster(@props.hotkey, @onHotkeyPressed) if @props.hotkey?

  componentWillUnmount: ->
    Keymaster.unbind(@props.hotkey) if @props.hotkey?

  render: ->
    props = _.omit(@props, 'icon', 'text')
    button props, _.compact [
      Icon {key: 'icon', name: @props.icon} if @props.icon?
      span {key: 'text'}, @props.text
    ]

  onHotkeyPressed: ->
    return unless @isMounted()
    @getDOMNode().click()

}

module.exports = Button
