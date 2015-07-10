#--------------------------------------------------------------------------------
React                = require 'react'
UserRenamedKindEvent = require 'events/ui/UserRenamedKindEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
CachedState          = require 'ui/framework/mixins/CachedState'
Button               = React.createFactory(require 'ui/common/Button')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogFooter         = React.createFactory(require 'ui/common/DialogFooter')
Field                = React.createFactory(require 'ui/common/Field')
FieldGroup           = React.createFactory(require 'ui/common/FieldGroup')
Input                = React.createFactory(require 'ui/common/Input')
{div}                = React.DOM
#--------------------------------------------------------------------------------

RenameKindDialog = React.createClass {

  displayName: 'RenameKindDialog'

  props:
    kindid:      PropTypes.Kind
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) ->
    kind = cache('kinds').get(@props.kindid)
    name  = kind.name if kind? and not @state?
    {name, kind}

  componentDidMount: ->
    @refs.name.focus()
    @refs.name.select()

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Rename Kind', onClick: @renameKind, disabled: !@isValid()}
        Button {text: 'Cancel',       onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'kind', title: "Rename #{@state.kind?.name}", footer, closeDialog: @props.closeDialog},
      Field {label: 'Name', note: "What would you like to call the kind?"},
        Input {ref: 'name', placeholder: 'ex. Feature, Support Request, Interview Candidate', value: @state.name, onChange: @onNameChanged}

  isValid: ->
    @state.name?.length > 0

  onNameChanged: (event) ->
    @setState {name: event.target.value}

  renameKind: ->
    unless @state.name == @state.kind.name
      @publish new UserRenamedKindEvent(@props.kindid, @state.name)
    @props.closeDialog()

}

module.exports = RenameKindDialog
