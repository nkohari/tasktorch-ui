_              = require 'lodash'
React          = require 'react'
NavigationItem = React.createFactory(require 'ui/shell/header/NavigationItem')
{div, ul}      = React.DOM

TopCenter = React.createClass {

  displayName: 'TopCenter'

  render: ->

    div {className: 'top-center'},
      ul {className: 'navigation'},
        NavigationItem {screen: 'workspace',  hotkey: 'w', title: 'Workspace'}
        NavigationItem {screen: 'bigpicture', hotkey: 'b', title: 'Big Picture'}
        #NavigationItem {screen: 'strategy',   hotkey: 's', title: 'Strategy'}
        #NavigationItem {screen: 'knowledge',  hotkey: 'k', title: 'Knowledge'}

}

module.exports = TopCenter
