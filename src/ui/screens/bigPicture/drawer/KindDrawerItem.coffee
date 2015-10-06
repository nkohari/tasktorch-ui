#--------------------------------------------------------------------------------
_                       = require 'lodash'
React                   = require 'react'
classSet                = require 'common/util/classSet'
UserToggledPanelEvent   = require 'events/ui/UserToggledPanelEvent'
PropTypes               = require 'ui/framework/PropTypes'
Actor                   = require 'ui/framework/mixins/Actor'
ViewContext             = require 'ui/framework/mixins/ViewContext'
BigPictureKindPanelSpec = require 'ui/framework/panels/BigPictureKindPanelSpec'
DrawerItem              = React.createFactory(require 'ui/common/DrawerItem')
Icon                    = React.createFactory(require 'ui/common/Icon')
#--------------------------------------------------------------------------------

KindDrawerItem = React.createClass {

  displayName: 'KindDrawerItem'

  propTypes:
    kind: PropTypes.Kind

  mixins: [Actor, ViewContext]

  render: ->

    classes = classSet [
      'kind'
      'active' if @isPanelOpen(@props.kind.id)
    ]

    DrawerItem {
      className: classes
      icon:      Icon {name: 'card', color: @props.kind?.color}
      label:     @props.kind.name
      onClick:   @toggleKind
    }    

  toggleKind: ->
    @publish new UserToggledPanelEvent(new BigPictureKindPanelSpec(@props.kind.id))

}

module.exports = KindDrawerItem
