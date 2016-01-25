#--------------------------------------------------------------------------------
moment               = require 'moment'
React                = require 'react'
UserCreatedGoalEvent = require 'events/ui/UserCreatedGoalEvent'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
IdentityContext      = require 'ui/framework/mixins/IdentityContext'
Button               = React.createFactory(require 'ui/common/Button')
Checkbox             = React.createFactory(require 'ui/common/Checkbox')
DateRangePicker      = React.createFactory(require 'ui/common/DateRangePicker')
Dialog               = React.createFactory(require 'ui/common/Dialog')
DialogFooter         = React.createFactory(require 'ui/common/DialogFooter')
Field                = React.createFactory(require 'ui/common/Field')
Input                = React.createFactory(require 'ui/common/Input')
CSSTransitionGroup   = React.createFactory(React.addons.CSSTransitionGroup)
#--------------------------------------------------------------------------------
require './CreateGoalDialog.styl'
#--------------------------------------------------------------------------------

CreateGoalDialog = React.createClass {

  displayEmail: 'CreateGoalDialog'

  propTypes:
    closeDialog: PropTypes.func

  mixins: [Actor, IdentityContext]

  getInitialState: -> {
    name: ''
    description: ''
    hasTimeframe: false
    timeframe: null
  }

  componentDidMount: ->
    @refs.name.focus()
    @refs.name.select()

  render: ->

    footer = DialogFooter {
      right: [
        Button {text: 'Create Goal', className: 'default', disabled: !@isValid(), onClick: @createGoal}
        Button {text: 'Cancel', onClick: @props.closeDialog}
      ]
    }

    Dialog {icon: 'goal', width: 630, className: 'create-goal-dialog', title: 'Create a Goal', footer, closeDialog: @props.closeDialog},
      Field {label: 'Name'},
        Input {ref: 'name', placeholder: 'ex. Beta Release, Project X, Save Money', value: @state.name, onChange: @onNameChanged}
      Field {label: 'Description'},
        Input {ref: 'description', placeholder: 'A brief description of what you want to accomplish together', value: @state.description, onChange: @onDescriptionChanged}
      Checkbox {text: 'This goal has a limited timeframe', onChange: @onTimeframeToggled}
      CSSTransitionGroup {className: 'date-range-picker-wrapper', component: 'div', transitionName: 'slide'},
        DateRangePicker {key: 'range-picker', onChange: @onTimeframeChanged} if @state.hasTimeframe

  isValid: ->
    @state.name?.length > 0

  onNameChanged: (event) ->
    @setState {name: event.target.value}

  onDescriptionChanged: (event) ->
    @setState {description: event.target.value}

  onTimeframeToggled: (event) ->
    hasTimeframe = event.target.checked
    if hasTimeframe
      timeframe = {from: new Date(), to: moment().add(1, 'months').toDate()}
    else
      timeframe = null
    @setState {hasTimeframe, timeframe}

  onTimeframeChanged: (timeframe) ->
    @setState {timeframe}

  createGoal: ->
    @publish new UserCreatedGoalEvent(@getCurrentOrg().id, @state.name, @state.description, @state.timeframe)
    @props.closeDialog()

}

module.exports = CreateGoalDialog
