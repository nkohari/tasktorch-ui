React      = require 'react'
KeyCode    = require 'framework/enums/KeyCode'
{textarea} = React.DOM

EditableTextBlock = React.createClass {

  displayName: 'EditableTextBlock'

  getInitialState: ->
    {dirty: false, previous: undefined, value: @props.value}

  componentWillReceiveProps: (newProps) ->
    @setState {dirty: false, previous: newProps.value, value: newProps.value}

  render: ->

    style = {}

    if @isMounted()
      node = @getDOMNode()
      if node.scrollHeight == node.clientHeight
        node.style.height = 'auto'
      style.height = node.scrollHeight

    classes = @props.className ? ''
    classes += ' dirty' if @state.dirty

    textarea {
      className:   classes
      style:       style
      placeholder: @props.placeholder
      value:       @state.value
      onChange:    @handleChange
      onFocus:     @handleFocus
      onBlur:      @handleBlur
      onKeyUp:     @handleKeyUp
    }

  handleKeyUp: (event) ->
    switch event.which
      when KeyCode.ESCAPE
        @setState {dirty: false, value: @state.previous}, =>
          @getDOMNode().blur()
      when KeyCode.RETURN
        if event.shiftKey
          @getDOMNode().blur()

  handleChange: (event) ->
    @setState {dirty: true, value: event.target.value}
    @props.onChange(event) if @props.onChange?

  handleFocus: ->
    @setState {previous: @state.value}

  handleBlur: ->
    @props.save(@state.value) if @props.save? and @state.dirty
    @setState {dirty: false}

}

module.exports = EditableTextBlock
