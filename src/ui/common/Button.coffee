_              = require 'lodash'
Keymaster      = require 'keymaster'
React          = require 'react'
PropTypes      = require 'framework/PropTypes'
mergeProps     = require 'framework/util/mergeProps'
Icon           = React.createFactory(require 'ui/common/Icon')
{span, button} = React.DOM

Button = React.createClass {

  displayName: 'Button'

  propTypes:
    icon: PropTypes.string
    text: PropTypes.string

  componentDidMount: ->
    Keymaster(@props.hotkey, @onHotkeyPressed) if @props.hotkey?

  componentWillUnmount: ->
    Keymaster.unbind(@props.hotkey) if @props.hotkey?

  render: ->

    classes = []
    classes.push('icon-only') if @props.icon? and not @props.text?

    props = mergeProps @props, _.omit(@props, 'icon', 'text'), {
      className: classes.join(' ')
    }

    button props,
      Icon {name: @props.icon} if @props.icon?
      span {}, @props.text

  onHotkeyPressed: ->
    return unless @isMounted()
    @getDOMNode().click()

}

module.exports = Button
