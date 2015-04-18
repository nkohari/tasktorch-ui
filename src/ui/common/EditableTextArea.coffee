_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
KeyCode    = require 'ui/framework/KeyCode'
classSet   = require 'common/util/classSet'
mergeProps = require 'common/util/mergeProps'
{textarea} = React.DOM

EditableTextArea = React.createClass {

  displayName: 'EditableTextArea'

  propTypes:
    value: PropTypes.any

  getInitialState: ->
    {dirty: false, previous: undefined, value: @props.value}

  componentWillReceiveProps: (newProps) ->
    @setState {dirty: false, previous: newProps.value, value: newProps.value}

  componentDidMount: ->
    node = @getDOMNode()
    node.style.height = "#{@getHeight()}px"

  render: ->

    classes = classSet [
      'editable'
      'dirty' if @state.dirty
    ]

    props = mergeProps _.omit(@props, 'value'), {
      className: classes
      style: {height: @getHeight()} if @isMounted()
      value: @state.value
      @onChange
      @onFocus
      @onBlur
      @onKeyUp
    }

    textarea props

  onKeyUp: (event) ->
    switch event.which
      when KeyCode.ESCAPE
        @setState {dirty: false, value: @state.previous}, =>
          @getDOMNode().blur()
      when KeyCode.RETURN
        if event.shiftKey
          @getDOMNode().blur()

  onChange: (event) ->
    @setState {dirty: true, value: event.target.value}
    @props.onChange(event) if @props.onChange?

  onFocus: ->
    @setState {previous: @state.value}

  onBlur: ->
    @props.save(@state.value) if @props.save? and @state.dirty
    @setState {dirty: false}

  getHeight: ->
    node = @getDOMNode()
    if node.scrollHeight == node.clientHeight
      node.style.height = 'auto'
    return node.scrollHeight

}

module.exports = EditableTextArea
