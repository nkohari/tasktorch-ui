React                        = require 'react'
PropTypes                    = require 'ui/framework/PropTypes'
ActionStatus                 = require 'data/enums/ActionStatus'
Actor                        = require 'ui/framework/mixins/Actor'
UserChangedActionStatusEvent = require 'events/ui/UserChangedActionStatusEvent'
Button                       = React.createFactory(require 'ui/common/Button')
Overlay                      = React.createFactory(require 'ui/common/Overlay')
Selector                     = React.createFactory(require 'ui/common/Selector')
ActionStatusSelectorOption   = React.createFactory(require 'ui/screens/workspace/panels/card/actions/overlays/ActionStatusSelectorOption')
{div}                        = React.DOM

ChangeActionStatusOverlay = React.createClass {

  displayName: 'ChangeActionStatusOverlay'

  propTypes:
    action:      PropTypes.Action
    hideOverlay: PropTypes.func

  mixins: [Actor]

  getInitialState: ->
    {status: @props.action.status}

  render: ->

    Overlay {arrow: true},
      Selector {selection: @state.status, onChange: @onStatusSelected},
        ActionStatusSelectorOption {value: ActionStatus.NotStarted, text: 'Not Started', icon: 'notstarted'}
        ActionStatusSelectorOption {value: ActionStatus.InProgress, text: 'In Progress', icon: 'inprogress'}
        ActionStatusSelectorOption {value: ActionStatus.Complete,   text: 'Complete',    icon: 'complete'}
        ActionStatusSelectorOption {value: ActionStatus.Warning,    text: 'Warning',     icon: 'warning'}
      div {className: 'buttons'},
        Button {className: 'small', text: 'OK',     onClick: @onOkClicked, disabled: @state.status == @props.action.status}
        Button {className: 'small', text: 'Cancel', onClick: @onCancelClicked}

  onStatusSelected: (status) ->
    @setState {status}

  onOkClicked: ->
    @publish new UserChangedActionStatusEvent(@props.action.id, @state.status)
    @props.hideOverlay()

  onCancelClicked: ->
    @props.hideOverlay()

}

module.exports = ChangeActionStatusOverlay
