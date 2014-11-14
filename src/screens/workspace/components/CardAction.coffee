React            = require 'react/addons'
Observe          = require 'mixins/Observe'
ActionStatus     = require 'framework/enums/ActionStatus'
Icon             = React.createFactory(require 'common/Icon')
Text             = React.createFactory(require 'common/Text')
{div, li, input} = React.DOM
{classSet}       = React.addons

CardAction = React.createClass {

  displayName: 'CardAction'

  mixins: [Observe()]

  render: ->
    li {className: "action #{@props.action.status.toLowerCase()}"}, [
      div {key: 'status', className: 'status'}, [
        Icon {key: 'icon', name: "action-#{@props.action.status.toLowerCase()}"}
      ]
      div {key: 'owner', className: 'owner unassigned'}, [
        Icon {key: 'icon', name: 'assign'}
      ]
      Text {key: 'text', className: 'text', value: @props.action.text}
      div {key: 'handle', className: 'handle'}, ['\u2630']
    ]

}

module.exports = CardAction
