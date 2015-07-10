#--------------------------------------------------------------------------------
React                     = require 'react'
UserChangedKindColorEvent = require 'events/ui/UserChangedKindColorEvent'
PropTypes                 = require 'ui/framework/PropTypes'
Actor                     = require 'ui/framework/mixins/Actor'
CachedState               = require 'ui/framework/mixins/CachedState'
Button                    = React.createFactory(require 'ui/common/Button')
ColorPicker               = React.createFactory(require 'ui/common/ColorPicker')
Dialog                    = React.createFactory(require 'ui/common/Dialog')
DialogFooter              = React.createFactory(require 'ui/common/DialogFooter')
Field                     = React.createFactory(require 'ui/common/Field')
FieldGroup                = React.createFactory(require 'ui/common/FieldGroup')
Input                     = React.createFactory(require 'ui/common/Input')
{div}                     = React.DOM
#--------------------------------------------------------------------------------

ChangeKindColorDialog = React.createClass {

  displayName: 'ChangeKindColorDialog'

  props:
    kindid:      PropTypes.Kind
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) ->
    kind  = cache('kinds').get(@props.kindid)
    color = kind.color if kind? and not @state?
    {color, kind}

  componentDidMount: ->
    @refs.input.focus()

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Change Color', onClick: @renameKind, disabled: !@isValid()}
        Button {text: 'Cancel',       onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'kind', title: "Change color of #{@state.kind?.name}", footer, closeDialog: @props.closeDialog},
      Field {label: 'Color'},
        ColorPicker {ref: 'input', value: @state.color, onChange: @onColorChanged}

  isValid: ->
    @state.color?.length > 0

  onColorChanged: (color) ->
    @setState {color}

  renameKind: ->
    unless @state.color == @state.kind.color
      @publish new UserChangedKindColorEvent(@props.kindid, @state.color)
    @props.closeDialog()

}

module.exports = ChangeKindColorDialog
