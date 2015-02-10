_              = require 'lodash'
React          = require 'react'
Router         = require 'react-router'
ShellUrl       = require 'framework/urls/ShellUrl'
NavigationItem = React.createFactory(require './NavigationItem')
{a, div, ul}   = React.DOM

NavigationMenu = React.createClass {

  displayName: 'NavigationMenu'

  mixins: [Router.State]
  
  render: ->
    activeScreen = @getActiveScreen()
    ul {className: 'navigation'}, [
      NavigationItem {key: 'workspace',  route: 'workspace',  title: 'Workspace'}
      NavigationItem {key: 'bigpicture', route: 'bigpicture', title: 'Big Picture'}
      NavigationItem {key: 'strategy',   route: 'strategy',   title: 'Strategy'}
    ]

  getActiveScreen: ->
    activeRoutes = @getRoutes()
    return activeRoutes[1].key

}

module.exports = NavigationMenu
