_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'common/PropTypes'
Observe             = require 'mixins/Observe'
CreateActionRequest = require 'requests/CreateActionRequest'
Icon                = React.createFactory(require 'common/Icon')
Button              = React.createFactory(require 'common/Button')
ActionList          = React.createFactory(require '../action/ActionList')
{div, span}         = React.DOM

CardActionsStage = React.createClass {

  displayName: 'CardActionsStage'

  propTypes:
    card:  PropTypes.Card
    kind:  PropTypes.Kind
    stage: PropTypes.Stage

  mixins: [Observe()]

  render: ->
    div {key: "stage-#{@props.stage.id}", className: 'stage'}, [
      div {key: 'title', className: 'title'}, [
        span {key: 'name', className: 'name'}, [@props.stage.name]
        div {key: 'controls', className: 'stage-controls'}, [
          Button {
            className: 'small'
            icon:      'action'
            text:      'Add Action to Stage'
            onClick:   @createAction
          }
        ]
      ]
      ActionList {
        key:  'actions'
        card:  @props.card
        kind:  @props.kind
        stage: @props.stage
        ids:   @props.card.actions[@props.stage.id]
      }
    ]

  createAction: ->
    @execute new CreateActionRequest(@props.card, @props.stage)

}

module.exports = CardActionsStage
