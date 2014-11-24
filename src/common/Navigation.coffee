_             = require 'lodash'
React         = require 'react/addons'
Router        = require 'react-router'
ActiveUrl     = require 'mixins/ActiveUrl'
ShellUrl      = require '../shell/ShellUrl'
Icon          = React.createFactory(require 'common/Icon')
Link          = React.createFactory(Router.Link)
{a, div}      = React.DOM
{classSet}    = React.addons

Screens =
  workspace:  'Workspace'
  bigpicture: 'Big Picture'
  planning:   'Planning'

Navigation = React.createClass {

  mixins: [ActiveUrl(ShellUrl)]

  displayName: 'Navigation'

  getInitialState: ->
    {expanded: false}

  render: ->

    if @state.expanded
      children = _.map Screens, (text, key) => @createLink(key, text)
    else
      children = [@createTrigger()]

    div {className: 'navigation'}, children

  onTriggerClicked: ->
    @setState {expanded: !@state.expanded}

  createTrigger: ->
    activeRoutes = @getActiveRoutes()
    route = activeRoutes[1].key
    text  = Screens[route]
    a {className: 'trigger', onClick: @onTriggerClicked}, [
      Icon {key: 'icon', name: route}
      text
    ]

  createLink: (route, text) ->
    url = @getActiveUrl()
    if @isActive(route)
      props = url.makeLinkProps(route, true)
    else
      props = url.makeLinkProps(route)
    props.key = route
    props.className = route
    Link props, [
      Icon {key: 'icon', name: route}
      text
    ]

}

module.exports = Navigation
