#--------------------------------------------------------------------------------
React                  = require 'react'
UserCreatedActionEvent = require 'events/ui/UserCreatedActionEvent'
KeyCode                = require 'ui/framework/KeyCode'
PropTypes              = require 'ui/framework/PropTypes'
Actor                  = require 'ui/framework/mixins/Actor'
Button                 = React.createFactory(require 'ui/common/Button')
Input                  = React.createFactory(require 'ui/common/Input')
{a, div}               = React.DOM
#--------------------------------------------------------------------------------
require './RepeatableInput.styl'
#--------------------------------------------------------------------------------

RepeatableInput = React.createClass {

  displayName: 'RepeatableInput'

  props:
    onValue:     PropTypes.func
    onDone:      PropTypes.func
    validator:   PropTypes.func
    placeholder: PropTypes.string
    actionText:  PropTypes.string
    doneText:    PropTypes.string

  getDefaultProps: -> {
    actionText: 'Create'
    doneText:   'Done'
    validator:  (text) -> text?.length > 0
  }

  getInitialState: ->
    {text: ''}

  componentDidMount: ->
    @refs.input.focus()

  render: ->

    div {className: 'repeatable-input'},
      Input {ref: 'input', placeholder: @props.placeholder, value: @state.text, @onKeyUp, @onChange}
      div {className: 'button-group'},
        Button {className: 'small', text: @props.actionText, disabled: !@props.validator(@state.text), onClick: @onActionClicked}
        Button {className: 'small', text: @props.doneText, onClick: @props.onDone}

  onKeyUp: (event) ->
    switch event.which
      when KeyCode.ESCAPE
        event.preventDefault()
        @props.onDone()
      when KeyCode.RETURN
        event.preventDefault()
        @addValue() if @props.validator(@state.text)
    return

  onActionClicked: ->
    @addValue(@state.text)
    @refs.input.focus()

  onChange: (event) ->
    @setState {text: event.target.value}

  addValue: ->
    @props.onValue(@state.text)
    @setState {text: ''}

}

module.exports = RepeatableInput
