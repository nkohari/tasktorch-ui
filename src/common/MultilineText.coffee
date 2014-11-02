React      = require 'react/addons'
Keys       = require '../Keys'
{classSet} = React.addons
{textarea} = React.DOM

MultilineText = React.createClass {

  displayName: 'MultilineText'

  getInitialState: ->
    {dirty: false, previous: undefined, value: @props.value}

  componentWillReceiveProps: (newProps) ->
    @setState {dirty: false, previous: newProps.value, value: newProps.value}

  render: ->

    classes = {dirty: @state.dirty}

    textarea {
      className:   classSet(classes)
      placeholder: @props.placeholder
      value:       @state.value
      onChange:    @handleChange
      onFocus:     @handleFocus
      onBlur:      @handleBlur
      onKeyUp:     @handleKeyUp
    }

  handleKeyUp: (event) ->
    switch event.which
      when Keys.ESCAPE
        @setState {dirty: false, value: @state.previous}, =>
          @getDOMNode().blur()
      when Keys.RETURN
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
