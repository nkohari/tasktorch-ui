#--------------------------------------------------------------------------------
_                      = require 'lodash'
React                  = require 'react'
classSet               = require 'common/util/classSet'
UserToggledDrawerEvent = require 'events/ui/UserToggledDrawerEvent'
Actor                  = require 'ui/framework/mixins/Actor'
ViewContext            = require 'ui/framework/mixins/ViewContext'
Icon                   = React.createFactory(require 'ui/common/Icon')
Link                   = React.createFactory(require 'ui/common/Link')
#--------------------------------------------------------------------------------

DrawerToggleButton = React.createClass {

  displayName: 'DrawerToggleButton'

  mixins: [Actor, ViewContext]

  render: ->

    classes = classSet [
      'drawer-toggle'
      'button'
      'icon-only'
      'active' if @isDrawerOpen()
    ]

    Link {className: classes, hotkey: 'd', onClick: @toggleDrawer},
      Icon {name: 'drawer'}

  toggleDrawer: ->
    @publish new UserToggledDrawerEvent()

}

module.exports = DrawerToggleButton
