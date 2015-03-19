_               = require 'lodash'
React           = require 'react'
ActionStatus    = require 'data/enums/ActionStatus'
PropTypes       = require 'ui/framework/PropTypes'
CachedState     = require 'ui/framework/mixins/CachedState'
StageCardAction = React.createFactory(require 'ui/screens/bigPicture/panels/kind/StageCardAction')
{div, ul}       = React.DOM

StageCardChecklist = React.createClass {

  displayName: 'StageCardChecklist'

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
        StageCardAction {key: action.id, stage: @props.stage, action}

    ul {className: 'stage-card-action-list'}, items

}

module.exports = StageCardChecklist
