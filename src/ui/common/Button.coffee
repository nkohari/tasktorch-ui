#--------------------------------------------------------------------------------
_              = require 'lodash'
Keymaster      = require 'keymaster'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
mergeProps     = require 'common/util/mergeProps'
Caret          = React.createFactory(require 'ui/common/Caret')
Icon           = React.createFactory(require 'ui/common/Icon')
{span, button} = React.DOM
#--------------------------------------------------------------------------------
require './Button.styl'
#--------------------------------------------------------------------------------

Button = React.createClass {

  displayName: 'Button'

  propTypes:
    caret: PropTypes.bool
    icon:  PropTypes.string
    text:  PropTypes.string

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
      Caret {} if @props.caret

  onHotkeyPressed: ->
    return unless @isMounted()
    @getDOMNode().click()

}

module.exports = Button
