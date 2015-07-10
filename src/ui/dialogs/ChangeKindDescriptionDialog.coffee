#--------------------------------------------------------------------------------
React                           = require 'react'
UserChangedKindDescriptionEvent = require 'events/ui/UserChangedKindDescriptionEvent'
PropTypes                       = require 'ui/framework/PropTypes'
Actor                           = require 'ui/framework/mixins/Actor'
CachedState                     = require 'ui/framework/mixins/CachedState'
Button                          = React.createFactory(require 'ui/common/Button')
Dialog                          = React.createFactory(require 'ui/common/Dialog')
DialogFooter                    = React.createFactory(require 'ui/common/DialogFooter')
Field                           = React.createFactory(require 'ui/common/Field')
FieldGroup                      = React.createFactory(require 'ui/common/FieldGroup')
Input                           = React.createFactory(require 'ui/common/Input')
{div}                           = React.DOM
#--------------------------------------------------------------------------------

ChangeKindDescriptionDialog = React.createClass {

  displayName: 'ChangeKindDescriptionDialog'

  props:
    kindid:      PropTypes.Kind
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) ->
    kind = cache('kinds').get(@props.kindid)
    description = kind.description if kind? and not @state?
    {description, kind}

  componentDidMount: ->
    @refs.input.focus()
    @refs.input.select()

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Change Description', onClick: @renameKind, disabled: !@isValid()}
        Button {text: 'Cancel',             onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'kind', title: "Change description of #{@state.kind?.name}", footer, closeDialog: @props.closeDialog},
      Field {label: 'Description'},
        Input {ref: 'input', placeholder: 'ex. Feature, Support Request, Interview Candidate', value: @state.description, onChange: @onDescriptionChanged}

  isValid: ->
    @state.description?.length > 0

  onDescriptionChanged: (event) ->
    @setState {description: event.target.value}

  renameKind: ->
    unless @state.description == @state.kind.description
      @publish new UserChangedKindDescriptionEvent(@props.kindid, @state.description)
    @props.closeDialog()

}

module.exports = ChangeKindDescriptionDialog
