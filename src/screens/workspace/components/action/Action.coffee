React                   = require 'react'
PropTypes               = require 'common/PropTypes'
Observe                 = require 'mixins/Observe'
Icon                    = React.createFactory(require 'common/Icon')
ActionStatus            = React.createFactory(require './ActionStatus')
ActionOwner             = React.createFactory(require './ActionOwner')
ActionText              = React.createFactory(require './ActionText')
ActionDeleteTrigger     = React.createFactory(require './ActionDeleteTrigger')
{div, li, input}        = React.DOM

Action = React.createClass {

  displayName: 'Action'

  propTypes:
    action: PropTypes.Action

  mixins: [Observe()]

  render: ->

    div {
      className: "action #{@props.action.status.toLowerCase()}"
    }, [
      ActionStatus {key: 'status', action: @props.action}
      ActionOwner  {key: 'owner',  action: @props.action}
      ActionText   {key: 'text',   action: @props.action}
      div {key: 'controls', className: 'action-controls'}, [
        Icon {key: 'handle', name: 'handle'}
        ActionDeleteTrigger {key: 'delete', action: @props.action}
      ]
    ]

}

module.exports = Action
