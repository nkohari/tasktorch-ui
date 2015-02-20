_        = require 'lodash'
React    = require 'react'
Router   = require 'react-router'
Url      = require 'framework/Url'
classSet = require 'framework/util/classSet'
Icon     = React.createFactory(require 'ui/common/Icon')
Link     = React.createFactory(require 'ui/common/Link')

SidebarToggleButton = React.createClass {

  displayName: 'SidebarToggleButton'

  mixins: [Router.State]

  render: ->

    url = new Url(this)
    isActive = url.sidebar

    classes = classSet [
      'button'
      'icon-only'
      'active' if isActive
    ]

    url.toggleSidebar()
    props = _.extend url.makeLinkProps(), {
      className: classes
      hotkey: 's'
    }

    icon = if isActive then 'chevron-left' else 'chevron-right'

    Link props,
      Icon {name: icon}

}

module.exports = SidebarToggleButton
