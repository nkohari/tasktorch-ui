_         = require 'lodash'
React     = require 'react'
classSet  = require 'common/util/classSet'
PanelKey  = require 'ui/framework/PanelKey'
PropTypes = require 'ui/framework/PropTypes'
UrlAware  = require 'ui/framework/mixins/UrlAware'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')
ListItem  = React.createFactory(require 'ui/common/ListItem')
{a, span} = React.DOM

TeamSidebarItem = React.createClass {

  displayName: 'TeamSidebarItem'

  propTypes:
    team: PropTypes.Team

  mixins: [UrlAware]

  render: ->

    ListItem {className: 'sidebar-item'},
      a {},
        Icon {name: 'team'}
        span {className: 'name'}, @props.team.name

}

module.exports = TeamSidebarItem
