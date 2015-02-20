_                            = require 'lodash'
React                        = require 'react'
PropTypes                    = require 'framework/PropTypes'
Observe                      = require 'framework/mixins/Observe'
KindStageListDisplayedEvent  = require 'events/display/KindStageListDisplayedEvent'
CardActionListDisplayedEvent = require 'events/display/CardActionListDisplayedEvent'
Frame                        = React.createFactory(require 'ui/common/Frame')
CardActionsStage             = React.createFactory(require 'ui/panels/card/CardActionsStage')

CardActions = React.createClass {

  displayName: 'CardActions'

  propTypes:
    card: PropTypes.Card.isRequired
    kind: PropTypes.Kind.isRequired

  mixins: [Observe('stages')]

  getInitialState: ->
    {expanded: true}

  componentDidMount: ->
    @publish new KindStageListDisplayedEvent(@props.kind.id, @props.kind.stages)
    @publish new CardActionListDisplayedEvent(@props.card.id, @props.card.actions)

  componentWillReceiveProps: (newProps) ->
    unless _.isEqual(newProps.kind.stages, @props.kind.stages)
      @publish new KindStageListDisplayedEvent(newProps.kind.id, newProps.kind.stages)
    unless _.isEqual(newProps.card.actions, @props.card.actions)
      @publish new CardActionListDisplayedEvent(newProps.card.id, newProps.card.actions)

  sync: (stores) ->
    {stages: stores.stages.getMany(@props.kind.stages)}

  isReady: ->
    @state.stages?

  render: ->

    stages = _.map @state.stages, (stage) =>
      CardActionsStage {key: "stage-#{stage.id}", card: @props.card, kind: @props.kind, stage: stage}
      
    Frame {@isReady, className: 'actions'}, stages

}

module.exports = CardActions
