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
require './CreateActionForm.styl'
#--------------------------------------------------------------------------------

CreateActionForm = React.createClass {

  displayName: 'CreateActionForm'

  props:
    checklist:    PropTypes.Checklist
    toggleAdding: PropTypes.func

  mixins: [Actor]

  getInitialState: ->
    {text: ''}

  componentDidMount: ->
    @refs.input.focus()

  render: ->

    div {className: 'create-action-form'},
      Input {
        ref: 'input'
        placeholder: 'What needs to be done?'
        value: @state.text
        @onKeyUp
        @onChange
      }
      div {className: 'button-group'},
        Button {
          className: 'small'
          text: 'Create'
          disabled: !@isValid()
          onClick: @createAction
        }
        Button {
          className: 'small'
          text: 'Done'
          onClick: @props.toggleAdding
        }

  isValid: ->
    @state.text?.length > 0

  onKeyUp: (event) ->
    switch event.which
      when KeyCode.ESCAPE
        event.preventDefault()
        @stopEditing()
      when KeyCode.RETURN
        event.preventDefault()
        @createAction()
    return

  onChange: (event) ->
    @setState {text: event.target.value}

  createAction: ->
    return unless @state.text?.length > 0
    @publish new UserCreatedActionEvent(@props.checklist.id, @state.text)
    @setState {text: ''}

}

module.exports = CreateActionForm
