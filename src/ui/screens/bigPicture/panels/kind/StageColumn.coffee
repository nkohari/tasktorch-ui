React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
Frame              = React.createFactory(require 'ui/common/Frame')
StageCardList      = React.createFactory(require 'ui/screens/bigPicture/panels/kind/StageCardList')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM

StageColumn = React.createClass {

  displayName: 'StageColumn'

  propTypes:
    stage: PropTypes.Stage

  mixins: [CachedState]

  getCachedState: (cache) -> {
    cards: cache('cardsByStage').get(@props.stage.id)
  }

  render: ->

    count  = @state.cards?.length or 0
    plural = if count == 1 then '' else 's'

    Frame {className: 'stage-column'},
      Frame {className: 'header'},
        div {className: 'name'}, @props.stage.name
        div {className: 'count'}, "#{count} card#{plural}"
      StageCardList {user: @props.user, stage: @props.stage, cards: @state.cards ? []}

}

module.exports = StageColumn
