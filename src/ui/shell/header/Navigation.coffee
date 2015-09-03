#--------------------------------------------------------------------------------
React          = require 'react'
NavigationItem = React.createFactory(require 'ui/shell/header/NavigationItem')
{ul}           = React.DOM
#--------------------------------------------------------------------------------
require './Navigation.styl'
#--------------------------------------------------------------------------------

Navigation = React.createClass {

  displayName: 'Navigation'

  render: ->

    ul {className: 'navigation'},
      NavigationItem {screen: 'workspace',  hotkey: 'w', title: 'Workspace'}
      NavigationItem {screen: 'bigpicture', hotkey: 'b', title: 'Big Picture'}
      #NavigationItem {screen: 'strategy',   hotkey: 's', title: 'Strategy'}
      #NavigationItem {screen: 'knowledge',  hotkey: 'k', title: 'Knowledge'}

}

module.exports = Navigation
