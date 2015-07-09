#--------------------------------------------------------------------------------
React                 = require 'react'
UserCreatedStageEvent = require 'events/ui/UserCreatedStageEvent'
PropTypes             = require 'ui/framework/PropTypes'
Actor                 = require 'ui/framework/mixins/Actor'
CachedState           = require 'ui/framework/mixins/CachedState'
Button                = React.createFactory(require 'ui/common/Button')
Dialog                = React.createFactory(require 'ui/common/Dialog')
DialogFooter          = React.createFactory(require 'ui/common/DialogFooter')
Field                 = React.createFactory(require 'ui/common/Field')
Input                 = React.createFactory(require 'ui/common/Input')
{div}                 = React.DOM
#--------------------------------------------------------------------------------

CreateStageDialog = React.createClass {

  displayName: 'CreateStageDialog'

  props:
    kindid:      PropTypes.id
    position:    PropTypes.number
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getInitialState: ->
    {dirty: false, name:  ''}

  getCachedState: (cache) -> {
    kind: cache('kinds').get(@props.kindid) if @props.kindid?
  }

  componentDidMount: ->
    @refs.name.focus()

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Create Stage', onClick: @createStage, disabled: !@isValid()}
        Button {text: 'Cancel',       onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'stack', title: "Create a new stage in #{@state.kind?.name}", footer, closeDialog: @props.closeDialog},
      Field {label: 'Name', hint: 'stages'},
        Input {ref: 'name', placeholder: 'ex. Plan, Build, Inform Customer', value: @state.name, onChange: @onNameChanged}

  isValid: ->
    @state.name?.length > 0

  onNameChanged: (event) ->
    @setState {dirty: true, name: event.target.value}

  createStage: ->
    @publish new UserCreatedStageEvent(@props.kindid, @state.name, @props.position)
    @props.closeDialog()

}

module.exports = CreateStageDialog
