React      = require 'react'
PropTypes  = require 'framework/PropTypes'
Button     = React.createFactory(require 'ui/common/Button')
Navigation = React.createFactory(require 'ui/shell/Navigation')
{a, div}   = React.DOM

ShellHeader = React.createClass {

  displayName: 'ShellHeader'

  propTypes:
    toggleSidebar: PropTypes.func

  render: ->
    div {className: 'shell-header'}, [
      Button     {key: 'sidebar-toggle', hotkey: 's', text: 'Sidebar', onClick: @props.toggleSidebar}
      Navigation {key: 'nav'}
    ]

}

module.exports = ShellHeader
