_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
Avatar             = React.createFactory(require 'ui/common/Avatar')
Frame              = React.createFactory(require 'ui/common/Frame')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM

StageColumn = React.createClass {

  displayName: 'StageColumn'

  propTypes:
    stage: PropTypes.Stage

  mixins: [CachedState]

  getCachedState: (cache) -> {
    cards: []
  }

  isReady: ->
    @state.cards?

  render: ->

    Frame {@isReady, className: 'stage-column'},
      Frame {className: 'header'},
        div {className: 'name'}, @props.stage.name
        div {className: 'count'}, "0 cards"
      div {}

}

module.exports = StageColumn
