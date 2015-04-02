React                 = require 'react'
UserRenamedStackEvent = require 'events/ui/UserRenamedStackEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
Button                = React.createFactory(require 'ui/common/Button')
Dialog                = React.createFactory(require 'ui/common/Dialog')
DialogButtons         = React.createFactory(require 'ui/common/DialogButtons')
Field                 = React.createFactory(require 'ui/common/Field')
FieldGroup            = React.createFactory(require 'ui/common/FieldGroup')
{div, input}          = React.DOM

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
    node = @refs.name.getDOMNode()
    node.focus()
    node.select()

  render: ->

    Dialog {icon: 'stack', title: "Rename #{@props.stack.name}", closeDialog: @props.closeDialog},
      FieldGroup {},
        Field {label: 'Name', note: 'ex. Big Ideas, 2015-Q3, Next Week, Beta Version Features'},
          input {ref: 'name', value: @state.name, onChange: @onNameChanged}
      DialogButtons {},
        Button {text: 'Rename Stack', disabled: !@isValid(), onClick: @renameStack}
        Button {text: 'Cancel',       onClick: @props.closeDialog}

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
