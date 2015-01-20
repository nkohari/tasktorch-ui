React                      = require 'react'
PropTypes                  = require 'common/PropTypes'
ActionStatus               = require 'framework/enums/ActionStatus'
Observe                    = require 'mixins/Observe'
ChangeActionStatusRequest  = require 'requests/ChangeActionStatusRequest'
Button                     = React.createFactory(require 'common/Button')
Selector                   = React.createFactory(require 'common/Selector')
ActionStatusSelectorOption = React.createFactory(require './ActionStatusSelectorOption')
{div}                      = React.DOM

ChangeActionStatusCommandPanel = React.createClass {

  displayName: 'ChangeActionStatusCommandPanel'

  propTypes:
    action:      PropTypes.Action
    hideCommand: PropTypes.func

  mixins: [Observe()]

  getInitialState: ->
    {status: @props.action.status}

  render: ->
    div {className: 'action-command'}, [
      Selector {selection: @state.status, onChange: @onStatusSelected}, [
        ActionStatusSelectorOption {value: ActionStatus.NotStarted, text: 'Not Started', icon: 'action-notstarted'}
        ActionStatusSelectorOption {value: ActionStatus.InProgress, text: 'In Progress', icon: 'action-inprogress'}
        ActionStatusSelectorOption {value: ActionStatus.Complete,   text: 'Complete',    icon: 'action-complete'}
        ActionStatusSelectorOption {value: ActionStatus.Warning,    text: 'Warning',     icon: 'action-warning'}
      ]
      div {className: 'buttons'}, [
        Button {key: 'ok',     className: 'small', text: 'OK',     onClick: @onOkClicked, disabled: @state.status == @props.action.status}
        Button {key: 'cancel', className: 'small', text: 'Cancel', onClick: @onCancelClicked}
      ]
    ]

  onStatusSelected: (status) ->
    @setState {status}

  onOkClicked: ->
    @execute new ChangeActionStatusRequest(@props.action, @state.status)
    @props.hideCommand()

  onCancelClicked: ->
    @props.hideCommand()

}

module.exports = ChangeActionStatusCommandPanel
