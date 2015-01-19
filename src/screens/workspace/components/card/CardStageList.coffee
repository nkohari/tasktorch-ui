_                            = require 'lodash'
React                        = require 'react'
PropTypes                    = require 'common/PropTypes'
Observe                      = require 'mixins/Observe'
KindStageListDisplayedEvent  = require 'events/display/KindStageListDisplayedEvent'
CardActionListDisplayedEvent = require 'events/display/CardActionListDisplayedEvent'
ActionList                   = React.createFactory(require '../action/ActionList')
CreateActionButton           = React.createFactory(require './CreateActionButton')
{div, span, ul, li}          = React.DOM

CardStageList = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardStageList'

  propTypes:
    card: PropTypes.Card.isRequired
    kind: PropTypes.Kind.isRequired

  mixins: [Observe('stages')]

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

    _.map @state.stages, (stage) =>
      div {key: "stage-#{stage.id}", className: 'stage'}, [
        div {key: 'title', className: 'title'}, [
          span {key: 'name', className: 'name'}, [stage.name]
          div {key: 'controls', className: 'stage-controls'}, [
            CreateActionButton {key: 'create', card: @props.card, stage}
          ]
        ]
        ActionList {
          key:  'actions'
          card:  @props.card
          kind:  @props.kind
          stage: stage
          ids:   @props.card.actions[stage.id]
        }
      ]

  #--------------------------------------------------------------------------------

}

module.exports = CardStageList
