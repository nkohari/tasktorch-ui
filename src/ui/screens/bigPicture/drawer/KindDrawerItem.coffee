_               = require 'lodash'
React           = require 'react'
classSet        = require 'common/util/classSet'
PropTypes       = require 'ui/framework/PropTypes'
Navigator       = require 'ui/framework/mixins/Navigator'
KindPanelState  = require 'ui/screens/bigPicture/panels/kind/KindPanelState'
Icon            = React.createFactory(require 'ui/common/Icon')
Link            = React.createFactory(require 'ui/common/Link')
ListItem        = React.createFactory(require 'ui/common/ListItem')
KindColorMarker = React.createFactory(require 'ui/common/KindColorMarker')
{span}          = React.DOM

KindDrawerItem = React.createClass {

  displayName: 'KindDrawerItem'

  propTypes:
    kind: PropTypes.Kind

  mixins: [Navigator]

  render: ->

    classes = classSet [
      'active' if @getScreen('bigpicture').isPanelVisible(@props.kind.id)
    ]

    ListItem {className: 'drawer-item'},
      Link {className: classes, onClick: @toggleKind},
        KindColorMarker {kind: @props.kind}
        span {className: 'name'}, @props.kind.name

  toggleKind: ->
    @getScreen('bigpicture').togglePanel(new KindPanelState(@props.kind.id))

}

module.exports = KindDrawerItem
