React         = require 'react/addons'
Router        = require 'react-router'
ActiveUrl     = require '../mixins/ActiveUrl'
NavigationUrl = require './NavigationUrl'
Icon          = React.createFactory(require './Icon')
Link          = React.createFactory(Router.Link)
{div}         = React.DOM
{classSet}    = React.addons

NavigationWidget = React.createClass {

  mixins: [ActiveUrl(NavigationUrl)]

  displayName: 'NavigationWidget'

  render: ->
    url = @getActiveUrl()
    div {className: 'navigation'}, [
      @makeLink('workspace', 'Workspace')
      @makeLink('bigpicture', 'Big Picture')
    ]

  makeLink: (route, text) ->
    url = @getActiveUrl()
    props = url.makeLinkProps(route)
    props.key = route
    props.className = route
    Link props, [
      Icon {name: route}
      text
    ]

}

module.exports = NavigationWidget
