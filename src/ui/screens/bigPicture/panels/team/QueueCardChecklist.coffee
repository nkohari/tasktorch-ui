_               = require 'lodash'
React           = require 'react'
ActionStatus    = require 'data/enums/ActionStatus'
PropTypes       = require 'ui/framework/PropTypes'
CachedState     = require 'ui/framework/mixins/CachedState'
QueueCardAction = React.createFactory(require 'ui/screens/bigPicture/panels/team/QueueCardAction')
{div, ul}       = React.DOM

QueueCardChecklist = React.createClass {

  displayName: 'QueueCardChecklist'

  propTypes:
    checklist: PropTypes.Checklist
    stage:     PropTypes.Stage

  mixins: [CachedState]

  getCachedState: (cache) -> {
    actions: cache('actionsByChecklist').get(@props.checklist.id)
  }

  render: ->

    if @state.actions?
      actionsToDisplay = _.filter @state.actions, (action) =>
        action.status == ActionStatus.InProgress or action.status == ActionStatus.Warning
      items = _.map actionsToDisplay, (action) =>
        QueueCardAction {key: action.id, stage: @props.stage, action}

    ul {className: 'queue-card-action-list'}, items

}

module.exports = QueueCardChecklist
