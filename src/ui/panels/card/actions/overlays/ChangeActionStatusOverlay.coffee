React                      = require 'react'
PropTypes                  = require 'framework/PropTypes'
ActionStatus               = require 'framework/enums/ActionStatus'
Observe                    = require 'framework/mixins/Observe'
ChangeActionStatusRequest  = require 'requests/ChangeActionStatusRequest'
Button                     = React.createFactory(require 'ui/common/Button')
Overlay                    = React.createFactory(require 'ui/common/Overlay')
Selector                   = React.createFactory(require 'ui/common/Selector')
ActionStatusSelectorOption = React.createFactory(require 'ui/panels/card/actions/overlays/ActionStatusSelectorOption')
{div}                      = React.DOM

ChangeActionStatusOverlay = React.createClass {

  displayName: 'ChangeActionStatusOverlay'

  propTypes:
    action: PropTypes.Action
    hide:   PropTypes.func

  mixins: [Observe()]

  getInitialState: ->
    {status: @props.action.status}

  render: ->

    Overlay {},
      Selector {selection: @state.status, onChange: @onStatusSelected},
        ActionStatusSelectorOption {value: ActionStatus.NotStarted, text: 'Not Started', icon: 'action-notstarted'}
        ActionStatusSelectorOption {value: ActionStatus.InProgress, text: 'In Progress', icon: 'action-inprogress'}
        ActionStatusSelectorOption {value: ActionStatus.Complete,   text: 'Complete',    icon: 'action-complete'}
        ActionStatusSelectorOption {value: ActionStatus.Warning,    text: 'Warning',     icon: 'action-warning'}
      div {className: 'buttons'},
        Button {className: 'small', text: 'OK',     onClick: @onOkClicked, disabled: @state.status == @props.action.status}
        Button {className: 'small', text: 'Cancel', onClick: @onCancelClicked}

  onStatusSelected: (status) ->
    @setState {status}

  onOkClicked: ->
    @execute new ChangeActionStatusRequest(@props.action, @state.status)
    @props.hide()

  onCancelClicked: ->
    @props.hide()

}

module.exports = ChangeActionStatusOverlay
