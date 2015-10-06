#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
mergeProps         = require 'common/util/mergeProps'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
Icon               = React.createFactory(require 'ui/common/Icon')
Panel              = React.createFactory(require 'ui/common/Panel')
PanelHeader        = React.createFactory(require 'ui/common/PanelHeader')
KindPanelColumn    = React.createFactory(require 'ui/screens/bigPicture/panels/kind/KindPanelColumn')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM
#--------------------------------------------------------------------------------

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

    columns = _.map @state.stages, (stage) =>
      KindPanelColumn {key: stage.id, kind: @state.kind, stage}

    icon = Icon {name: 'card', color: @state.kind?.color}

    props = mergeProps _.omit(@props, 'type'), {
      className: 'big-picture'
    }

    Panel props,
      PanelHeader {panelid: @props.id, icon},
        @state.kind?.name
      div {className: 'content'}, columns
      div {className: 'footer'}

}

module.exports = KindPanel
