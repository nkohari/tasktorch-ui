_               = require 'lodash'
React           = require 'react'
classSet        = require 'common/util/classSet'
ActionStatus    = require 'data/enums/ActionStatus'
PropTypes       = require 'ui/framework/PropTypes'
CachedState     = require 'ui/framework/mixins/CachedState'
QueueCardAction = React.createFactory(require 'ui/screens/bigPicture/panels/team/QueueCardAction')
{div, ul}       = React.DOM

QueueCardChecklist = React.createClass {

  displayName: 'QueueCardChecklist'

  propTypes:
    card:      PropTypes.Card
    kind:      PropTypes.Kind
    checklist: PropTypes.Checklist
    stage:     PropTypes.Stage
    user:      PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) -> {
    actions: cache('actionsByChecklist').get(@props.checklist.id)
  }

  render: ->

    if @state.actions?
      actionsToDisplay = _.filter @state.actions, (action) =>
        action.status == ActionStatus.InProgress or action.status == ActionStatus.Warning
      items = _.map actionsToDisplay, (action) =>
        QueueCardAction {key: action.id, card: @props.card, stage: @props.stage, user: @props.user, action}

    classes = classSet [
      'big-picture-card-action-list'
      'empty' if items?.length == 0
    ]

    ul {className: classes}, items

}

module.exports = QueueCardChecklist
