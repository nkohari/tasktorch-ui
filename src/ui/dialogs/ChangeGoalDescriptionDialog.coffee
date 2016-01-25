#--------------------------------------------------------------------------------
React                           = require 'react'
UserChangedGoalDescriptionEvent = require 'events/ui/UserChangedGoalDescriptionEvent'
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

ChangeGoalDescriptionDialog = React.createClass {

  displayName: 'ChangeGoalDescriptionDialog'

  props:
    goalid:      PropTypes.Goal
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) ->
    goal = cache('goals').get(@props.goalid)
    description = goal.description if goal? and not @state?
    {description, goal}

  componentDidMount: ->
    @refs.input.focus()
    @refs.input.select()

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Change Description', onClick: @renameGoal, disabled: !@isValid()}
        Button {text: 'Cancel',             onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'goal', title: "Change description of #{@state.goal?.name}", footer, closeDialog: @props.closeDialog},
      Field {label: 'Description'},
        Input {ref: 'input', value: @state.description, placeholder: 'A brief description of what you want to accomplish together', onChange: @onDescriptionChanged}

  isValid: ->
    @state.description?.length > 0

  onDescriptionChanged: (event) ->
    @setState {description: event.target.value}

  renameGoal: ->
    unless @state.description == @state.goal.description
      @publish new UserChangedGoalDescriptionEvent(@props.goalid, @state.description)
    @props.closeDialog()

}

module.exports = ChangeGoalDescriptionDialog
