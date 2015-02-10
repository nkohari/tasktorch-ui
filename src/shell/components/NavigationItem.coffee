_         = require 'lodash'
React     = require 'react'
Router    = require 'react-router'
ShellUrl  = require 'framework/urls/ShellUrl'
Hotlink   = React.createFactory(require 'common/Hotlink')
{li}      = React.DOM

NavigationItem = React.createClass {

  displayName: 'NavigationItem'

  mixins: [Router.State]

  render: ->
    li {}, [
      Hotlink @makeLinkProps(), [@props.title]
    ]

  makeLinkProps: ->
    url   = new ShellUrl(this)
    props = url.makeLinkProps(@props.route)
    _.extend props, {key: 'link', className: @props.route}

}

module.exports = NavigationItem
