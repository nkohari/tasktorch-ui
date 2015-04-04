React                  = require 'react'
KeyCode                = require 'data/enums/KeyCode'
UserCreatedActionEvent = require 'events/ui/UserCreatedActionEvent'
PropTypes              = require 'ui/framework/PropTypes'
Actor                  = require 'ui/framework/mixins/Actor'
Button                 = React.createFactory(require 'ui/common/Button')
{a, div, input}        = React.DOM

CreateActionForm = React.createClass {

  displayName: 'CreateActionForm'

  props:
    checklist:    PropTypes.Checklist
    toggleAdding: PropTypes.func

  mixins: [Actor]

  getInitialState: ->
    {text: ''}

  componentDidMount: ->
    @refs.input.getDOMNode().focus()

  render: ->

    div {className: 'create-action-form'},
      input {
        ref: 'input'
        value: @state.text
        @onKeyUp
        @onChange
      }
      div {className: 'buttons'},
        Button {
          className: 'small'
          text: 'Create'
          onClick: @createAction
        }
        Button {
          className: 'small'
          text: 'Done'
          onClick: @props.toggleAdding
        }

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
