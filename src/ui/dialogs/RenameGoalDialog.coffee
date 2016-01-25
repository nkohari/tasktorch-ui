#--------------------------------------------------------------------------------
React                = require 'react'
UserRenamedGoalEvent = require 'events/ui/UserRenamedGoalEvent'
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

RenameGoalDialog = React.createClass {

  displayName: 'RenameGoalDialog'

  props:
    goalid:      PropTypes.Goal
    closeDialog: PropTypes.func

  mixins: [Actor, CachedState]

  getCachedState: (cache) ->
    goal = cache('goals').get(@props.goalid)
    name  = goal.name if goal? and not @state?
    {name, goal}

  componentDidMount: ->
    @refs.name.focus()
    @refs.name.select()

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Rename Goal', onClick: @renameGoal, disabled: !@isValid()}
        Button {text: 'Cancel',       onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'goal', title: "Rename #{@state.goal?.name}", footer, closeDialog: @props.closeDialog},
      Field {label: 'Name', note: "What would you like to call the goal?"},
        Input {ref: 'name', placeholder: 'ex. Beta Release, Project X, Save Money', value: @state.name, onChange: @onNameChanged}

  isValid: ->
    @state.name?.length > 0

  onNameChanged: (event) ->
    @setState {name: event.target.value}

  renameGoal: ->
    unless @state.name == @state.goal.name
      @publish new UserRenamedGoalEvent(@props.goalid, @state.name)
    @props.closeDialog()

}

module.exports = RenameGoalDialog
