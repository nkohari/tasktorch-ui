React            = require 'react/addons'
Observe          = require 'mixins/Observe'
ActionStatus     = require 'framework/enums/ActionStatus'
Icon             = React.createFactory(require 'common/Icon')
Text             = React.createFactory(require 'common/Text')
OverlayTrigger   = React.createFactory(require 'common/OverlayTrigger')
Tooltip          = React.createFactory(require 'common/Tooltip')
{div, li, input} = React.DOM
{classSet}       = React.addons

CardAction = React.createClass {

  displayName: 'CardAction'

  mixins: [Observe()]

  render: ->
    tooltip = Tooltip {text: @props.action.status}
    trigger = OverlayTrigger {container: @props.overlayContainer, placement: 'right', trigger: 'click', overlay: tooltip},
      div {key: 'status', className: 'status'}, [
        Icon {key: 'icon', name: "action-#{@props.action.status.toLowerCase()}"}
      ]

    li {className: "action #{@props.action.status.toLowerCase()}"}, [
      trigger
      div {key: 'owner', className: 'owner unassigned'}, [
        Icon {key: 'icon', name: 'assign'}
      ]
      Text {key: 'text', className: 'text', value: @props.action.text}
      div {key: 'handle', className: 'handle'}, ['\u2630']
    ]

}

module.exports = CardAction
