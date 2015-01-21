_                            = require 'lodash'
React                        = require 'react'
PropTypes                    = require 'common/PropTypes'
Observe                      = require 'mixins/Observe'
KindStageListDisplayedEvent  = require 'events/display/KindStageListDisplayedEvent'
CardActionListDisplayedEvent = require 'events/display/CardActionListDisplayedEvent'
CardActionsStage             = React.createFactory(require './CardActionsStage')
{div, span, ul, li}          = React.DOM

CardActionsBlock = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardActionsBlock'

  propTypes:
    card: PropTypes.Card.isRequired
    kind: PropTypes.Kind.isRequired

  mixins: [Observe('stages')]

  getInitialState: ->
    {expanded: true}

  # Lifecycle ---------------------------------------------------------------------

  componentWillMount: ->
    @publish new KindStageListDisplayedEvent(@props.kind.id, @props.kind.stages)
    @publish new CardActionListDisplayedEvent(@props.card.id, @props.card.actions)

  componentWillReceiveProps: (newProps) ->
    unless _.isEqual(newProps.kind.stages, @props.kind.stages)
      @publish new KindStageListDisplayedEvent(newProps.kind.id, newProps.kind.stages)
    unless _.isEqual(newProps.card.actions, @props.card.actions)
      @publish new CardActionListDisplayedEvent(newProps.card.id, newProps.card.actions)

  # State -------------------------------------------------------------------------
  
  sync: (stores) ->
    {stages: stores.stages.getMany(@props.kind.stages)}

  ready: ->
    {stages: @state.stages?}

  # Rendering ---------------------------------------------------------------------

  render: ->
    div {className: 'actions'}, @contents()

  children: ->
    if @state.expanded
      @renderExpanded()
    else
      @renderCompact()

  renderExpanded: ->
    _.map @state.stages, (stage) =>
      CardActionsStage {key: "stage-#{stage.id}", card: @props.card, kind: @props.kind, stage: stage}

  renderCompact: ->
    # TODO

  #--------------------------------------------------------------------------------

}

module.exports = CardActionsBlock