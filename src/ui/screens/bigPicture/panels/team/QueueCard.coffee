_                  = require 'lodash'
moment             = require 'moment'
React              = require 'react'
ActionStatus       = require 'data/enums/ActionStatus'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
ListItem           = React.createFactory(require 'ui/common/ListItem')
Time               = React.createFactory(require 'ui/common/Time')
QueueCardChecklist = React.createFactory(require 'ui/screens/bigPicture/panels/team/QueueCardChecklist')
{div}              = React.DOM

QueueCard = React.createClass {

  displayName: 'QueueCard'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState]

  getCachedState: (cache) -> {
    kind:       cache('kinds').get(@props.card.kind)
    checklists: cache('checklistsByCard').get(@props.card.id)
    stages:     cache('stagesByKind').get(@props.card.kind)
  }

  isReady: ->
    @state.kind? and @state.checklists? and @state.stages?

  render: ->

    style = {borderLeftColor: @state.kind?.color}

    if @state.checklists? and @state.stages?
      lookup = _.indexBy(@state.stages, 'id')
      checklists = _.map @state.checklists, (checklist) =>
        stage = lookup[checklist.stage]
        QueueCardChecklist {key: checklist.id, card: @props.card, kind: @props.kind, checklist, stage}

    ListItem {@isReady},
      div {className: 'queue-card', style},
        div {className: 'title'}, @props.card.title or 'Untitled Card'
        checklists

}

module.exports = QueueCard
