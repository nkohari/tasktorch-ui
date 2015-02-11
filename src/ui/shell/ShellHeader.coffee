_          = require 'lodash'
React      = require 'react'
Router     = require 'react-router'
PropTypes  = require 'framework/PropTypes'
Url        = require 'framework/Url'
Button     = React.createFactory(require 'ui/common/Button')
Frame      = React.createFactory(require 'ui/common/Frame')
Link       = React.createFactory(require 'ui/common/Link')
Navigation = React.createFactory(require 'ui/shell/Navigation')

ShellHeader = React.createClass {

  displayName: 'ShellHeader'

  mixins: [Router.State]

  render: ->

    url = new Url(this)
    url.sidebar = !url.sidebar
    props = _.extend url.makeLinkProps(), {className: 'sidebar-toggle', hotkey: 's'}

    Frame {className: 'shell-header'},
      Link props, 'Sidebar'
      Navigation {key: 'nav'}

}

module.exports = ShellHeader
