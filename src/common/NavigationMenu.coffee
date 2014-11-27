_                  = require 'lodash'
React              = require 'react/addons'
ActiveUrl          = require 'mixins/ActiveUrl'
ShellUrl           = require '../shell/ShellUrl'
NavigationMenuItem = React.createFactory(require 'common/NavigationMenuItem')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{a, div, ul}       = React.DOM

ScreenNames =
  workspace:  'Workspace'
  bigpicture: 'Big Picture'
  planning:   'Planning'

NavigationMenu = React.createClass {

  mixins: [ActiveUrl(ShellUrl)]

  displayName: 'NavigationMenu'

  getInitialState: ->
    {expanded: false}

  render: ->

    classes = 'navigation'

    if @state.expanded
      classes = 'navigation expanded'
      drop = ul {key: 'list', className: 'drop'}, [
        NavigationMenuItem {
          key: 'workspace'
          route: 'workspace'
          title: 'Workspace'
          description: 'Manage your tactics'
        }
        NavigationMenuItem {
          key: 'bigpicture'
          route: 'bigpicture'
          title: 'Big Picture'
          description: 'See what everyone is working on'
        }
        NavigationMenuItem {
          key: 'planning'
          route: 'planning'
          title: 'Planning'
          description: 'Organize your strategy'
        }
      ]

    activeScreen = @getActiveScreen()
    div {className: classes}, [
      a {key: 'trigger', className: 'trigger', onClick: @onTriggerClicked}, [ScreenNames[activeScreen]]
      CSSTransitionGroup {key: 'drop', component: 'div', transitionName: 'slide'}, [drop]
    ]

  onTriggerClicked: ->
    @setState {expanded: !@state.expanded}

  getActiveScreen: ->
    activeRoutes = @getActiveRoutes()
    return activeRoutes[1].key

}

module.exports = NavigationMenu
