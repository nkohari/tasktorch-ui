_              = require 'lodash'
React          = require 'react'
List           = React.createFactory(require 'ui/common/List')
NavigationItem = React.createFactory(require 'ui/shell/header/NavigationItem')

NavigationMenu = React.createClass {

  displayName: 'NavigationMenu'

  render: ->
    List {className: 'navigation'},
      NavigationItem {screen: 'workspace',  title: 'Workspace'}
      NavigationItem {screen: 'bigpicture', title: 'Big Picture'}
      NavigationItem {screen: 'strategy',   title: 'Strategy'}

}

module.exports = NavigationMenu
