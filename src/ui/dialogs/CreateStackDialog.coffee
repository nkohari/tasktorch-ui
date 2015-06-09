React                     = require 'react'
UserCreatedStackEvent     = require 'events/ui/UserCreatedStackEvent'
UserCreatedTeamStackEvent = require 'events/ui/UserCreatedTeamStackEvent'
PropTypes                 = require 'ui/framework/PropTypes'
Actor                     = require 'ui/framework/mixins/Actor'
CachedState               = require 'ui/framework/mixins/CachedState'
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
    teamid:      PropTypes.id
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getInitialState: -> {
    dirty: false
    name:  ''
  }

  getCachedState: (cache) -> {
    team: cache('teams').get(@props.teamid) if @props.teamid?
  }

  componentDidMount: ->
    @refs.name.focus()

  render: ->

    buttons = DialogButtons {},
      Button {text: 'Create Stack', onClick: @createStack, disabled: !@isValid()}
      Button {text: 'Cancel',       onClick: @props.closeDialog}

    Dialog {icon: 'stack', title: "Create a stack", buttons, closeDialog: @props.closeDialog},
      Field {label: 'Name', hint: 'stacks'},
        Input {ref: 'name', placeholder: 'ex. Big Ideas, 2015-Q3, Next Week, Remaining Beta Version Features', value: @state.name, onChange: @onNameChanged}

  isValid: ->
    @state.name?.length > 0

  onNameChanged: (event) ->
    @setState {dirty: true, name: event.target.value}

  createStack: ->
    if @props.teamid?
      @publish new UserCreatedTeamStackEvent(@props.teamid, @state.name)
    else
      @publish new UserCreatedStackEvent(@state.name)
    @props.closeDialog()

}

module.exports = CreateStackDialog
