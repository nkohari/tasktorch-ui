React                     = require 'react'
UserCreatedStackEvent     = require 'events/ui/UserCreatedStackEvent'
UserCreatedTeamStackEvent = require 'events/ui/UserCreatedTeamStackEvent'
PropTypes                 = require 'ui/framework/PropTypes'
Actor                     = require 'ui/framework/mixins/Actor'
Button                    = React.createFactory(require 'ui/common/Button')
Dialog                    = React.createFactory(require 'ui/common/Dialog')
DialogButtons             = React.createFactory(require 'ui/common/DialogButtons')
Field                     = React.createFactory(require 'ui/common/Field')
FieldGroup                = React.createFactory(require 'ui/common/FieldGroup')
{div, input}              = React.DOM

CreateStackDialog = React.createClass {

  displayName: 'CreateStackDialog'

  props:
    team:        PropTypes.Team
    closeDialog: PropTypes.func

  mixins: [Actor]

  getInitialState: -> {
    dirty: false
    name:  ''
  }

  componentDidMount: ->
    node = @refs.name.getDOMNode()
    node.focus()
    node.select()

  render: ->

    Dialog {icon: 'stack-backlog', title: "Create a stack", closeDialog: @props.closeDialog},
      FieldGroup {},
        Field {label: 'Name', note: 'ex. Big Ideas, 2015-Q3, Next Week, Beta Version Features'},
          input {ref: 'name', value: @state.name, onChange: @onNameChanged}
      DialogButtons {},
        Button {text: 'Create Stack', disabled: !@isValid(), onClick: @createStack}
        Button {text: 'Cancel', onClick: @props.closeDialog}

  isValid: ->
    @state.name?.length > 0

  onNameChanged: (event) ->
    @setState {dirty: true, name: event.target.value}

  createStack: ->
    if @props.team?
      @publish new UserCreatedTeamStackEvent(@props.team.id, @state.name)
    else
      @publish new UserCreatedStackEvent(@state.name)
    @props.closeDialog()

}

module.exports = CreateStackDialog
