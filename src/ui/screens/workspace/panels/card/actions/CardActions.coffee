_             = require 'lodash'
React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
CachedState   = require 'ui/framework/mixins/CachedState'
Frame         = React.createFactory(require 'ui/common/Frame')
CardChecklist = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardChecklist')

CardActions = React.createClass {

  displayName: 'CardActions'

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
      
    Frame {className: 'content stage-list'}, items

}

module.exports = CardActions
