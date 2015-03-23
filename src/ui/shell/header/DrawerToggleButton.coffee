_         = require 'lodash'
React     = require 'react'
classSet  = require 'common/util/classSet'
Navigator = require 'ui/framework/mixins/Navigator'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')

DrawerToggleButton = React.createClass {

  displayName: 'DrawerToggleButton'

  mixins: [Navigator]

  render: ->

    isActive = @getCurrentScreen().isDrawerVisible()

    classes = classSet [
      'button'
      'icon-only'
      'active' if isActive
    ]

    Link {className: classes, hotkey: 'd', onClick: @toggleDrawer},
      Icon {name: if isActive then 'chevron-left' else 'chevron-right'}

  toggleDrawer: ->
    @getCurrentScreen().toggleDrawer()

}

module.exports = DrawerToggleButton
