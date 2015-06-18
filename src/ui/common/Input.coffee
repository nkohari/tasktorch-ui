#--------------------------------------------------------------------------------
_                         = require 'lodash'
React                     = require 'react'
PropTypes                 = require 'ui/framework/PropTypes'
classSet                  = require 'common/util/classSet'
mergeProps                = require 'common/util/mergeProps'
Icon                      = React.createFactory(require 'ui/common/Icon')
{div, label, span, input} = React.DOM
#--------------------------------------------------------------------------------
require './Input.styl'
#--------------------------------------------------------------------------------

Input = React.createClass {

  displayName: 'Input'

  propTypes:
    icon:        PropTypes.string
    placeholder: PropTypes.string
    rightIcon:   PropTypes.string
    value:       PropTypes.any

  getDefaultProps: ->
    {type: 'text'}

  getInitialState: ->
    {focused: false}

  render: ->

    if @props.placeholder? and (not @props.value? or @props.value.length == 0)
      placeholder = span {className: 'input-placeholder'}, @props.placeholder

    classes = classSet [
      'input'
      'has-left-icon'  if @props.icon?
      'has-right-icon' if @props.rightIcon?
    ]

    props = mergeProps _.omit(@props, 'icon', 'rightIcon', 'placeholder'), {
      ref: 'input'
    }

    div {className: classes},
      Icon {name: @props.icon, className: 'left-icon',  onClick: @focus} if @props.icon?
      input props
      Icon {name: @props.rightIcon, className: 'right-icon', onClick: @focus} if @props.rightIcon?
      placeholder

  focus: ->
    return unless @isMounted()
    @refs.input.getDOMNode().focus()

  blur: ->
    return unless @isMounted()
    @refs.input.getDOMNode().blur()

  select: ->
    return unless @isMounted()
    @refs.input.getDOMNode().select()

}

module.exports = Input
