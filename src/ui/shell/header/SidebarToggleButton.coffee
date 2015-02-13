_      = require 'lodash'
React  = require 'react'
Router = require 'react-router'
Url    = require 'framework/Url'
Icon   = React.createFactory(require 'ui/common/Icon')
Link   = React.createFactory(require 'ui/common/Link')

SidebarToggleButton = React.createClass {

  displayName: 'SidebarToggleButton'

  mixins: [Router.State]

  render: ->

    url = new Url(this)

    classes = ['button', 'icon-only']
    classes.push('active') if url.sidebar

    url.toggleSidebar()
    props = _.extend url.makeLinkProps(), {
      className: classes.join(' ')
      hotkey: 's'
    }

    Link props,
      Icon {name: 'handle'}

}

module.exports = SidebarToggleButton
