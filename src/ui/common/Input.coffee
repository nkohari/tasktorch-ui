_                         = require 'lodash'
React                     = require 'react'
PropTypes                 = require 'ui/framework/PropTypes'
classSet                  = require 'common/util/classSet'
mergeProps                = require 'common/util/mergeProps'
Icon                      = React.createFactory(require 'ui/common/Icon')
{div, label, span, input} = React.DOM

Input = React.createClass {

  displayName: 'Input'

  propTypes:
    icon:        PropTypes.string
    placeholder: PropTypes.string
    rightIcon:   PropTypes.string
    value:       PropTypes.any

  getInitialState: ->
    {focused: false}

  render: ->

    if @props.placeholder? and (not @props.value? or @props.value.length == 0)
      placeholder = span {className: 'input-placeholder', onClick: @focus}, @props.placeholder

    classes = classSet [
      'input'
      'has-left-icon'  if @props.icon?
      'has-right-icon' if @props.rightIcon?
    ]

    props = mergeProps _.omit(@props, 'icon', 'rightIcon', 'placeholder', 'value'), {
      ref:   'input'
      value: @props.value
      @onFocus
      @onBlur
    }

    div {className: classes},
      Icon {name: @props.icon,      className: 'left-icon',  onClick: @focus} if @props.icon?
      input props
      Icon {name: @props.rightIcon, className: 'right-icon', onClick: @focus} if @props.rightIcon?
      placeholder

  focus: ->
    return unless @isMounted()
    @refs.input.getDOMNode().focus()

  select: ->
    return unless @isMounted()
    @refs.input.getDOMNode().select()

  onFocus: (event) ->
    @props.onFocus(event) if @props.onFocus?

  onBlur: (event) ->
    @props.onBlur(event) if @props.onBlur?

}

module.exports = Input
