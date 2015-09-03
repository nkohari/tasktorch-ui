#--------------------------------------------------------------------------------
_              = require 'lodash'
React          = require 'react'
classSet       = require 'common/util/classSet'
PropTypes      = require 'ui/framework/PropTypes'
Navigator      = require 'ui/framework/mixins/Navigator'
KindPanelState = require 'ui/screens/bigPicture/panels/kind/KindPanelState'
DrawerItem     = React.createFactory(require 'ui/common/DrawerItem')
Icon           = React.createFactory(require 'ui/common/Icon')
#--------------------------------------------------------------------------------

KindDrawerItem = React.createClass {

  displayName: 'KindDrawerItem'

  propTypes:
    kind: PropTypes.Kind

  mixins: [Navigator]

  render: ->

    classes = classSet [
      'kind'
      'active' if @getScreen('bigpicture').isPanelVisible(@props.kind.id)
    ]

    DrawerItem {
      className: classes
      icon:      Icon {name: 'card', color: @props.kind?.color}
      label:     @props.kind.name
      onClick:   @toggleKind
    }    

  toggleKind: ->
    @getScreen('bigpicture').togglePanel(new KindPanelState(@props.kind.id))

}

module.exports = KindDrawerItem
