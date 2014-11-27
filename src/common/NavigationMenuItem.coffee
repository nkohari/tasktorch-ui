_         = require 'lodash'
React     = require 'react/addons'
ActiveUrl = require 'mixins/ActiveUrl'
ShellUrl  = require '../shell/ShellUrl'
Hotlink   = React.createFactory(require 'common/Hotlink')
Icon      = React.createFactory(require 'common/Icon')
{li, div} = React.DOM
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)

NavigationMenuItem = React.createClass {

  mixins: [ActiveUrl(ShellUrl)]

  displayName: 'NavigationMenuItem'

  render: ->
    url   = @getActiveUrl()
    props = _.extend url.makeLinkProps(@props.route), {key: 'link', className: @props.route}
    CSSTransitionGroup {component: 'li', transitionName: 'slide'}, [
      Hotlink props, [
        Icon {key: 'icon', name: @props.route}
        div {key: 'title', className: 'title'}, [@props.title]
        div {key: 'description', className: 'description'}, [@props.description]
      ]
    ]

}

module.exports = NavigationMenuItem
