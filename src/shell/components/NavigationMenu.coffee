React         = require 'react/addons'
Router        = require 'react-router'
ActiveUrl     = require 'mixins/ActiveUrl'
ShellUrl      = require '../ShellUrl'
Icon          = React.createFactory(require 'common/Icon')
Link          = React.createFactory(Router.Link)
{div}         = React.DOM
{classSet}    = React.addons

NavigationMenu = React.createClass {

  mixins: [ActiveUrl(ShellUrl)]

  displayName: 'NavigationMenu'

  render: ->
    url = @getActiveUrl()
    div {className: 'navigation'}, [
      @makeLink('workspace',  'Workspace')
      @makeLink('bigpicture', 'Big Picture')
      @makeLink('planning',   'Planning')
    ]

  makeLink: (route, text) ->
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

module.exports = NavigationMenu
