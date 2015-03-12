React        = require 'react'
ActionStatus = require 'data/enums/ActionStatus'
PropTypes    = require 'ui/framework/PropTypes'
Icon         = React.createFactory(require 'ui/common/Icon')
{em}         = React.DOM

ActionStatusWidget = React.createClass {

  displayName: 'ActionStatusWidget'

  propTypes:
    status: PropTypes.enum(ActionStatus)

  render: ->

    em {className: 'action-status-widget'},
      Icon {name: "action-#{@props.status.toLowerCase()}"}
      @getActionStatusText()

  getActionStatusText: ->

    switch @props.status
      when ActionStatus.NotStarted then 'Not Started'
      when ActionStatus.InProgress then 'In Progress'
      when ActionStatus.Complete   then 'Complete'
      when ActionStatus.Warning    then 'Warning'

}

module.exports = ActionStatusWidget
