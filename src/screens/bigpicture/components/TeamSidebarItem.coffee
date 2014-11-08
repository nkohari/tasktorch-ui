_             = require 'lodash'
React         = require 'react/addons'
Router        = require 'react-router'
ActiveUrl     = require 'mixins/ActiveUrl'
BigPictureUrl = require '../BigPictureUrl'
Icon          = React.createFactory(require 'common/Icon')
Link          = React.createFactory(Router.Link)
{li, span}    = React.DOM

TeamSidebarItem = React.createClass {

  displayName: 'TeamSidebarItem'

  mixins: [ActiveUrl(BigPictureUrl)]

  render: ->
    linkProps = _.extend @makeLinkProps(), {key: 'open-team-link'}
    li {className: 'team-list-item'}, [
      Link linkProps, [
        Icon {key: 'icon', name: 'team'}
        span {key: 'name', className: 'team-name'}, [@props.team.name]
      ]
    ]

  makeLinkProps: ->
    url = @getActiveUrl()
    url.setUsers _.pluck(@props.team.members, 'id')
    return url.makeLinkProps()

}

module.exports = TeamSidebarItem
