React                 = require 'react'
UserRenamedStackEvent = require 'events/ui/UserRenamedStackEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
Button                = React.createFactory(require 'ui/common/Button')
Dialog                = React.createFactory(require 'ui/common/Dialog')
DialogButtons         = React.createFactory(require 'ui/common/DialogButtons')
Field                 = React.createFactory(require 'ui/common/Field')
FieldGroup            = React.createFactory(require 'ui/common/FieldGroup')
Input                 = React.createFactory(require 'ui/common/Input')
{div}                 = React.DOM

RenameStackDialog = React.createClass {

  displayName: 'RenameStackDialog'

  props:
    stack:        PropTypes.Stack
    closeDialog: PropTypes.func

  mixins: [Actor]

  getInitialState: -> {
    name:     @props.stack.name
    previous: @props.stack.name
    dirty:    false
  }

  componentDidMount: ->
    @refs.name.focus()
    @refs.name.select()

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Rename Stack', onClick: @renameStack, disabled: !@isValid()}
      Button {text: 'Cancel',       onClick: @props.closeDialog}

    Dialog {icon: 'stack', title: "Rename #{@props.stack.name}", buttons, closeDialog: @props.closeDialog},
      Field {label: 'Name', note: "What would you like to call the stack?"},
        Input {ref: 'name', placeholder: 'ex. Big Ideas, 2015-Q3, Next Week, Beta Version Features', value: @state.name, onChange: @onNameChanged}

  isValid: ->
    @state.name?.length > 0

  onNameChanged: (event) ->
    @setState {
      name: event.target.value
      dirty: event.target.value != @state.previous
    }

  renameStack: ->
    unless @state.name == @state.previous
      @publish new UserRenamedStackEvent(@props.stack.id, @state.name)
    @props.closeDialog()

}

module.exports = RenameStackDialog
