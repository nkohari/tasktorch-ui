_                        = require 'lodash'
React                    = require 'react'
Observe                  = require 'mixins/Observe'
LoadActionsByCardRequest = require 'requests/LoadActionsByCardRequest'
LoadStagesByKindRequest  = require 'requests/LoadStagesByKindRequest'
CardActionGroup          = React.createFactory(require './CardActionGroup')
{div, ul, li}            = React.DOM

CardActions = React.createClass {

  displayName: 'CardActions'

  mixins: [Observe('actions', 'stages')]

  getStateFromStores: (stores) ->
    return {
      stages: stores.stages.getStagesByKind(@props.kind.id)
      actions: stores.actions.getActionsByCard(@props.card.id)
    }

  componentWillMount: ->
    @execute new LoadActionsByCardRequest(@props.card.id)
    @execute new LoadStagesByKindRequest(@props.kind.id)

  isReady: ->
    @state.stages? and @state.actions?

  render: ->
    children = if @isReady() then @renderChildren() else []
    div {className: 'actions'}, children

  renderChildren: ->
    _.map @state.stages, (stage) =>
      actions = _.filter @state.actions, (action) -> action.stage.id == stage.id
      CardActionGroup {key: "stage-#{stage.id}", card: @props.card, kind: @props.kind, stage, actions}

}

module.exports = CardActions
