_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
Frame              = React.createFactory(require 'ui/common/Frame')
KindColorMarker    = React.createFactory(require 'ui/common/KindColorMarker')
PanelCloseLink     = React.createFactory(require 'ui/common/PanelCloseLink')
StageColumn        = React.createFactory(require 'ui/screens/bigPicture/panels/kind/StageColumn')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM

KindPanel = React.createClass {

  displayName: 'KindPanel'

  propTypes:
    id: PropTypes.id

  mixins: [CachedState]

  getCachedState: (cache) ->
    kind   = cache('kinds').get(@props.id)
    stages = cache('stagesByKind').get(@props.id)
    {kind, stages}

  render: ->

    items = _.map @state.stages, (stage) =>
      StageColumn {key: stage.id, stage}

    Frame {className: 'kind panel'},
      PanelCloseLink {id: @props.id}
      div {className: 'header'},
        KindColorMarker {kind: @state.kind}
        @state.kind?.name
      div {className: 'columns'}, items
      div {className: 'footer'}

}

module.exports = KindPanel
