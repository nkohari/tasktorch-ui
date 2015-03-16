_                    = require 'lodash'
React                = require 'react'
CachedState          = require 'ui/framework/mixins/CachedState'
PropTypes            = require 'ui/framework/PropTypes'
Frame                = React.createFactory(require 'ui/common/Frame')
TabBlock             = React.createFactory(require 'ui/common/TabBlock')
PeopleSidebarPanel   = React.createFactory(require 'ui/screens/bigPicture/sidebar/PeopleSidebarPanel')
ProgressSidebarPanel = React.createFactory(require 'ui/screens/bigPicture/sidebar/ProgressSidebarPanel')

BigPictureSidebar = React.createClass {

  displayName: 'BigPictureSidebar'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'big-picture sidebar'},
      TabBlock {selected: 'people'},
        PeopleSidebarPanel   {key: 'people',   title: 'People',   currentOrg: @props.currentOrg, currentUser: @props.currentUser}
        ProgressSidebarPanel {key: 'progress', title: 'Progress', currentOrg: @props.currentOrg, currentUser: @props.currentUser}

}

module.exports = BigPictureSidebar
