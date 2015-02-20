React      = require 'react'
KeyCode    = require 'framework/enums/KeyCode'
classSet   = require 'framework/util/classSet'
mergeProps = require 'framework/util/mergeProps'
{textarea} = React.DOM

EditableTextArea = React.createClass {

  displayName: 'EditableTextArea'

  getInitialState: ->
    {dirty: false, previous: undefined, value: @props.value}

  componentWillReceiveProps: (newProps) ->
    @setState {dirty: false, previous: newProps.value, value: newProps.value}

  componentWillUpdate: ->
    console.log "componentWillUpdate: height = #{@getDOMNode()?.scrollHeight}"

  componentDidUpdate: ->
    console.log "componentDidUpdate: height = #{@getDOMNode()?.scrollHeight}"

  render: ->

    style = {}

    if @isMounted()
      node = @getDOMNode()
      if node.scrollHeight == node.clientHeight
        node.style.height = 'auto'
      style.height = node.scrollHeight
      console.log "height = #{style.height}"

    classes = classSet [
      'dirty' if @state.dirty
    ]

    props = mergeProps @props, {
      className: classes
      style: style
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

}

module.exports = EditableTextArea
