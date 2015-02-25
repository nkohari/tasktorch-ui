_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
Icon       = React.createFactory(require 'ui/common/Icon')
Button     = React.createFactory(require 'ui/common/Button')
ActionList = React.createFactory(require 'ui/panels/card/actions/ActionList')
{div}      = React.DOM

CardActionsStage = React.createClass {

  displayName: 'CardActionsStage'

  propTypes:
    actions: PropTypes.arrayOf(PropTypes.Action)
    card:    PropTypes.Card
    kind:    PropTypes.Kind
    stage:   PropTypes.Stage

  render: ->

    div {className: 'stage'},
      div {className: 'title'}, @props.stage.name
      ActionList {
        key:     'actions'
        actions: @props.actions
        card:    @props.card
        kind:    @props.kind
        stage:   @props.stage
        ids:     @props.card.actions[@props.stage.id]
      }

}

module.exports = CardActionsStage
