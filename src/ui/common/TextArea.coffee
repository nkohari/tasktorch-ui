#--------------------------------------------------------------------------------
_                     = require 'lodash'
classSet              = require 'common/util/classSet'
mergeProps            = require 'common/util/mergeProps'
React                 = require 'react'
PropTypes             = require 'ui/framework/PropTypes'
{div, span, textarea} = React.DOM
#--------------------------------------------------------------------------------

TextArea = React.createClass {

  displayName: 'TextArea'

  propTypes:
    flexible: PropTypes.bool

  getDefaultProps: ->
    {flexible: true}

  componentDidMount: ->
    @adjustHeight() if @props.flexible

  componentDidUpdate: ->
    @adjustHeight() if @props.flexible

  render: ->

    if @props.placeholder? and (not @props.value? or @props.value.length == 0)
      placeholder = span {className: 'input-placeholder', onClick: @focus}, @props.placeholder

    classes = classSet [
      'input'
      'multiline'
    ]

    props = mergeProps _.omit(@props, 'flexible', 'placeholder'), {
      ref: 'textarea'
      style: {height: @getHeight()} if @props.flexible and @isMounted()
    }

    div {className: classes},
      textarea props
      placeholder

  focus: ->
    return unless @isMounted()
    @refs.textarea.getDOMNode().focus()

  blur: ->
    return unless @isMounted()
    @refs.textarea.getDOMNode().blur()

  select: ->
    return unless @isMounted()
    @refs.textarea.getDOMNode().select()

  adjustHeight: ->
    node = @refs.textarea.getDOMNode()
    node.style.height = "#{@getHeight()}px"

  getHeight: ->
    return undefined unless @isMounted()
    node = @refs.textarea.getDOMNode()
    if node.scrollHeight == node.clientHeight
      node.style.height = 'auto'
    return node.scrollHeight

}

module.exports = TextArea
