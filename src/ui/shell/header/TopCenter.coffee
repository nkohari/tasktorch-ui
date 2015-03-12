_              = require 'lodash'
React          = require 'react'
NavigationItem = React.createFactory(require 'ui/shell/header/NavigationItem')
{div, ul}      = React.DOM

TopCenter = React.createClass {

  displayName: 'TopCenter'

  render: ->

    div {className: 'top-center'},
      ul {className: 'navigation'},
        NavigationItem {screen: 'workspace',  title: 'Workspace'}
        NavigationItem {screen: 'bigpicture', title: 'Big Picture'}
        NavigationItem {screen: 'strategy',   title: 'Strategy'}

}

module.exports = TopCenter
