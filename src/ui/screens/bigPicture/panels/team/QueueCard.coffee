_                  = require 'lodash'
moment             = require 'moment'
React              = require 'react'
ActionStatus       = require 'data/enums/ActionStatus'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
Navigator          = require 'ui/framework/mixins/Navigator'
CardPanelState     = require 'ui/screens/workspace/panels/card/CardPanelState'
Card               = React.createFactory(require 'ui/common/Card')
CardFollowToggle   = React.createFactory(require 'ui/common/CardFollowToggle')
CardLink           = React.createFactory(require 'ui/common/CardLink')
CardLocation       = React.createFactory(require 'ui/common/CardLocation')
QueueCardChecklist = React.createFactory(require 'ui/screens/bigPicture/panels/team/QueueCardChecklist')
{div}              = React.DOM

QueueCard = React.createClass {

  displayName: 'QueueCard'

  propTypes:
    card:  PropTypes.Card
    stack: PropTypes.Stack
    user:  PropTypes.User

  mixins: [CachedState, Navigator]

  getCachedState: (cache) -> {
    kind:       cache('kinds').get(@props.card.kind)
    checklists: cache('checklistsByCard').get(@props.card.id)
    stages:     cache('stagesByKind').get(@props.card.kind)
  }

  render: ->

    if @state.checklists? and @state.stages?
      lookup = _.indexBy(@state.stages, 'id')
      checklists = _.map @state.checklists, (checklist) =>
        stage = lookup[checklist.stage]
        QueueCardChecklist {key: checklist.id, card: @props.card, kind: @props.kind, user: @props.user, checklist, stage}

    Card {className: 'big-picture-card', card: @props.card},
      div {className: 'card-summary'},
        div {className: 'card-info'},
          div {className: 'title'}, @props.card.title or 'Untitled Card'
        div {className: 'controls'},
          CardFollowToggle {card: @props.card}
          CardLink {card: @props.card}
      checklists

}

module.exports = QueueCard
