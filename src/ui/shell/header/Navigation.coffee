_              = require 'lodash'
React          = require 'react'
Router         = require 'react-router'
Url            = require 'framework/Url'
List           = React.createFactory(require 'ui/common/List')
NavigationItem = React.createFactory(require 'ui/shell/header/NavigationItem')

NavigationMenu = React.createClass {

  displayName: 'NavigationMenu'

  mixins: [Router.State]
  
  render: ->
    activeScreen = @getActiveScreen()
    List {className: 'navigation'},
      NavigationItem {screen: 'workspace',  title: 'Workspace',   activeScreen}
      NavigationItem {screen: 'bigpicture', title: 'Big Picture', activeScreen}
      NavigationItem {screen: 'strategy',   title: 'Strategy',    activeScreen}

  getActiveScreen: ->
    activeRoutes = @getRoutes()
    return activeRoutes[1].key

}

module.exports = NavigationMenu
