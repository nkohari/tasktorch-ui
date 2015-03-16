_                   = require 'lodash'
moment              = require 'moment'
React               = require 'react'
ActionStatus        = require 'data/enums/ActionStatus'
PropTypes           = require 'ui/framework/PropTypes'
CachedState         = require 'ui/framework/mixins/CachedState'
ListItem            = React.createFactory(require 'ui/common/ListItem')
Time                = React.createFactory(require 'ui/common/Time')
QueueCardActionList = React.createFactory(require 'ui/screens/bigPicture/panels/team/QueueCardActionList')
{div}               = React.DOM

QueueCard = React.createClass {

  displayName: 'QueueCard'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState]

  getCachedState: (cache) -> {
    kind:    cache('kinds').get(@props.card.kind)
    actions: cache('actionsByCard').get(@props.card.id)
    stages:  cache('stagesByKind').get(@props.card.kind)
  }

  isReady: ->
    @state.kind? and @state.actions? and @state.stages?

  render: ->

    style = {borderLeftColor: @state.kind?.color}

    ListItem {@isReady},
      div {className: 'queue-card', style},
        div {className: 'title'}, @props.card.title or 'Untitled Card'
        @renderActionLists()

  renderActionLists: ->

    return undefined unless @state.actions? and @state.stages?

    actionsToDisplay = _.filter @state.actions, (action) ->
      action.status == ActionStatus.InProgress or action.status == ActionStatus.Warning

    lookup = _.object _.map actionsToDisplay, (action) -> [action.id, action]

    _.map @state.stages, (stage) =>
      actions = _.compact _.map @props.card.actions[stage.id], (id) => lookup[id]
      return undefined unless actions.length > 0
      QueueCardActionList {key: stage.id, card: @props.card, kind: @props.kind, stage, actions}

}

module.exports = QueueCard
