_                   = require 'lodash'
React               = require 'react'
PropTypes           = require 'framework/PropTypes'
Observe             = require 'framework/mixins/Observe'
CreateActionRequest = require 'requests/CreateActionRequest'
Icon                = React.createFactory(require 'ui/common/Icon')
Button              = React.createFactory(require 'ui/common/Button')
ActionList          = React.createFactory(require 'ui/panels/card/actions/ActionList')
{div, span}         = React.DOM

CardActionsStage = React.createClass {

  displayName: 'CardActionsStage'

  propTypes:
    card:  PropTypes.Card
    kind:  PropTypes.Kind
    stage: PropTypes.Stage

  mixins: [Observe()]

  render: ->

    div {key: "stage-#{@props.stage.id}", className: 'stage'},
      div {className: 'title'},
        span {className: 'name'}, @props.stage.name
        div {className: 'stage-controls'},
          Button {
            className: 'small'
            text:      'Add Action'
            onClick:   @createAction
          }
      ActionList {
        key:  'actions'
        card:  @props.card
        kind:  @props.kind
        stage: @props.stage
        ids:   @props.card.actions[@props.stage.id]
      }

  createAction: ->
    @execute new CreateActionRequest(@props.card, @props.stage)

}

module.exports = CardActionsStage
