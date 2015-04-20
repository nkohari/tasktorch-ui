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
Input                     = React.createFactory(require 'ui/common/Input')
{div}                     = React.DOM

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
    @refs.name.focus()

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Create Stack', onClick: @createStack, disabled: !@isValid()}
      Button {text: 'Cancel',       onClick: @props.closeDialog}

    Dialog {icon: 'stack', title: "Create a stack", buttons, closeDialog: @props.closeDialog},
      Field {label: 'Name', hint: @renderHint()},
        Input {ref: 'name', placeholder: 'ex. Big Ideas, 2015-Q3, Next Week, Beta Version Features', value: @state.name, onChange: @onNameChanged}

  isValid: ->
    @state.name?.length > 0

  onNameChanged: (event) ->
    @setState {dirty: true, name: event.target.value}

  renderHint: ->

    hint = """
      If you aren't ready to work on a card yet, you can set it aside in a stack
      and come back to it later.
    """

    if @props.team?
      hint += " This stack will belong to #{@props.team.name}, and all of the cards stored in it will be shared by the team."
    else
      hint += " This stack will belong to you, so all of the cards stored in it are your responsibility."

    return hint

  createStack: ->
    if @props.team?
      @publish new UserCreatedTeamStackEvent(@props.team.id, @state.name)
    else
      @publish new UserCreatedStackEvent(@state.name)
    @props.closeDialog()

}

module.exports = CreateStackDialog
