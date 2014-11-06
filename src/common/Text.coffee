React      = require 'react/addons'
KeyCode    = require 'framework/enums/KeyCode'
{classSet} = React.addons
{input}    = React.DOM

Text = React.createClass {

  displayName: 'Text'

  getInitialState: ->
    {dirty: false, previous: @props.value, value: @props.value}

  componentWillReceiveProps: (newProps) ->
    @setState {dirty: false, previous: newProps.value, value: newProps.value}

  render: ->
    input {
      className:   classSet {editable: true, dirty: @state.dirty}
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
        @getDOMNode().blur()

  handleChange: (event) ->
    @setState {dirty: true, value: event.target.value}

  handleFocus: ->
    @setState {previous: @state.value}

  handleBlur: ->
    @props.save(@state.value) if @state.dirty
    @setState {dirty: false}

}

module.exports = Text
