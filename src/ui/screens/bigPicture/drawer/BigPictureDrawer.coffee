_                   = require 'lodash'
React               = require 'react'
CachedState         = require 'ui/framework/mixins/CachedState'
PropTypes           = require 'ui/framework/PropTypes'
Frame               = React.createFactory(require 'ui/common/Frame')
TabBlock            = React.createFactory(require 'ui/common/TabBlock')
PeopleDrawerPanel   = React.createFactory(require 'ui/screens/bigPicture/drawer/PeopleDrawerPanel')
ProgressDrawerPanel = React.createFactory(require 'ui/screens/bigPicture/drawer/ProgressDrawerPanel')

BigPictureDrawer = React.createClass {

  displayName: 'BigPictureDrawer'

  propTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  render: ->

    Frame {className: 'big-picture drawer'},
      TabBlock {selected: 'people'},
        PeopleDrawerPanel   {key: 'people',   title: 'People',   currentOrg: @props.currentOrg, currentUser: @props.currentUser}
        ProgressDrawerPanel {key: 'progress', title: 'Progress', currentOrg: @props.currentOrg, currentUser: @props.currentUser}

}

module.exports = BigPictureDrawer
