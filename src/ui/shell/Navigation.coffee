_              = require 'lodash'
React          = require 'react'
Router         = require 'react-router'
Url            = require 'framework/Url'
List           = React.createFactory(require 'ui/common/List')
NavigationItem = React.createFactory(require 'ui/shell/NavigationItem')

NavigationMenu = React.createClass {

  displayName: 'NavigationMenu'

  mixins: [Router.State]
  
  render: ->
    activeScreen = @getActiveScreen()
    List {className: 'navigation'}, [
      NavigationItem {key: 'workspace',  screen: 'workspace',  title: 'Workspace'}
      NavigationItem {key: 'bigpicture', screen: 'bigpicture', title: 'Big Picture'}
      NavigationItem {key: 'strategy',   screen: 'strategy',   title: 'Strategy'}
    ]

  getActiveScreen: ->
    activeRoutes = @getRoutes()
    return activeRoutes[1].key

}

module.exports = NavigationMenu
