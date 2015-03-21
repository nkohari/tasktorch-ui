_                  = require 'lodash'
moment             = require 'moment'
React              = require 'react'
ActionStatus       = require 'data/enums/ActionStatus'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
Navigator          = require 'ui/framework/mixins/Navigator'
CardPanelState     = require 'ui/screens/workspace/panels/card/CardPanelState'
Link               = React.createFactory(require 'ui/common/Link')
ListItem           = React.createFactory(require 'ui/common/ListItem')
QueueCardChecklist = React.createFactory(require 'ui/screens/bigPicture/panels/team/QueueCardChecklist')
{div}              = React.DOM

QueueCard = React.createClass {

  displayName: 'QueueCard'

  propTypes:
    card: PropTypes.Card

  mixins: [CachedState, Navigator]

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
      Link {className: 'queue-card', style, onClick: @showCard},
        div {className: 'title'}, @props.card.title or 'Untitled Card'
        checklists

  showCard: ->
    @getScreen('workspace').addPanel(new CardPanelState(@props.card.id))

}

module.exports = QueueCard
