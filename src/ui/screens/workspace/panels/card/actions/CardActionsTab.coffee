_             = require 'lodash'
React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
CachedState   = require 'ui/framework/mixins/CachedState'
CardChecklist = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardChecklist')
{div}         = React.DOM

CardActionsTab = React.createClass {

  displayName: 'CardActionsTab'

  propTypes:
    card: PropTypes.Card
    kind: PropTypes.Kind

  mixins: [CachedState]

  getInitialState: ->
    {expanded: true}

  getCachedState: (cache) -> {
    checklists: cache('checklistsByCard').get(@props.card.id)
    stages:     cache('stagesByKind').get(@props.kind.id)
  }

  render: ->

    if @state.checklists? and @state.stages?
      lookup = _.indexBy(@state.checklists, 'stage')
      items = _.map @state.stages, (stage) =>
        checklist = lookup[stage.id]
        CardChecklist {key: checklist.id, card: @props.card, kind: @props.kind, stage, checklist}
      
    div {className: 'card-actions-tab'}, items

}

module.exports = CardActionsTab
