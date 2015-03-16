_                = require 'lodash'
React            = require 'react'
PropTypes        = require 'ui/framework/PropTypes'
CachedState      = require 'ui/framework/mixins/CachedState'
Frame            = React.createFactory(require 'ui/common/Frame')
CardActionsStage = React.createFactory(require 'ui/screens/workspace/panels/card/CardActionsStage')

CardActions = React.createClass {

  displayName: 'CardActions'

  propTypes:
    card: PropTypes.Card
    kind: PropTypes.Kind

  mixins: [CachedState]

  getInitialState: ->
    {expanded: true}

  getCachedState: (cache) -> {
    actions: cache('actionsByCard').get(@props.card.id)
    stages:  cache('stagesByKind').get(@props.kind.id)
  }

  render: ->

    if @state.actions? and @state.stages?
      lookup = _.object _.map @state.actions, (action) -> [action.id, action]
      stages = _.map @state.stages, (stage) =>
        actions = _.compact _.map @props.card.actions[stage.id], (id) => lookup[id]
        CardActionsStage {key: "stage-#{stage.id}", card: @props.card, kind: @props.kind, stage: stage, actions}
      
    Frame {className: 'content stage-list'}, stages

}

module.exports = CardActions
