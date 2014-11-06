React      = require 'react/addons'
KeyCode    = require 'framework/enums/KeyCode'
{classSet} = React.addons
{textarea} = React.DOM

MultilineText = React.createClass {

  displayName: 'MultilineText'

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

    textarea {
      className:   classSet {editable: true, overflow: 'hidden', dirty: @state.dirty}
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

  handleFocus: ->
    @setState {previous: @state.value}

  handleBlur: ->
    @props.save(@state.value) if @state.dirty
    @setState {dirty: false}

}

module.exports = MultilineText
