_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
Frame              = React.createFactory(require 'ui/common/Frame')
KindIcon           = React.createFactory(require 'ui/common/KindIcon')
PanelHeader        = React.createFactory(require 'ui/common/PanelHeader')
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
      PanelHeader {panelid: @props.id, icon: KindIcon {kind: @state.kind}},
        @state.kind?.name
      div {className: 'columns'}, items
      div {className: 'footer'}

}

module.exports = KindPanel
