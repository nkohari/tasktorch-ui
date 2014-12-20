_                            = require 'lodash'
React                        = require 'react'
PropTypes                    = require 'common/PropTypes'
Observe                      = require 'mixins/Observe'
KindStageListDisplayedEvent  = require 'events/display/KindStageListDisplayedEvent'
CardActionListDisplayedEvent = require 'events/display/CardActionListDisplayedEvent'
CardActionGroup              = React.createFactory(require './CardActionGroup')
{div, ul, li}                = React.DOM

CardActions = React.createClass {

  # Spec --------------------------------------------------------------------------

  displayName: 'CardActions'

  propTypes:
    card: PropTypes.Card.isRequired
    kind: PropTypes.Kind.isRequired

  mixins: [Observe('actions', 'stages')]

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
    return {
      stages:  stores.stages.getAllByKind(@props.kind.id)
      actions: stores.actions.getAllByCard(@props.card.id)
    }

  ready: ->
    return {
      stages:  @state.stages?
      actions: @state.actions?
    }

  # Rendering ---------------------------------------------------------------------

  render: ->
    div {className: 'actions'}, @renderChildrenIfReady()

  children: ->
    _.map @state.stages, (stage) =>
      # TODO: This should use groupBy
      actions = _.filter @state.actions, (action) -> action.stage == stage.id
      CardActionGroup {key: "stage-#{stage.id}", card: @props.card, kind: @props.kind, stage, actions}

  #--------------------------------------------------------------------------------

}

module.exports = CardActions
