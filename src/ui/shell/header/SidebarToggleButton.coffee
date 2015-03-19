_         = require 'lodash'
React     = require 'react'
classSet  = require 'common/util/classSet'
Navigator = require 'ui/framework/mixins/Navigator'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')

SidebarToggleButton = React.createClass {

  displayName: 'SidebarToggleButton'

  mixins: [Navigator]

  render: ->

    isActive = @getCurrentScreen().isSidebarVisible()

    classes = classSet [
      'button'
      'icon-only'
      'active' if isActive
    ]

    Link {className: classes, hotkey: 's', onClick: @toggleSidebar},
      Icon {name: if isActive then 'chevron-left' else 'chevron-right'}

  toggleSidebar: ->
    @getCurrentScreen().toggleSidebar()

}

module.exports = SidebarToggleButton
