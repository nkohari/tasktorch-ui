#--------------------------------------------------------------------------------
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
TabBlock       = React.createFactory(require 'ui/common/TabBlock')
UserProfileTab = React.createFactory(require 'ui/screens/workspace/panels/user/UserProfileTab')
UserQueueTab   = React.createFactory(require 'ui/screens/workspace/panels/user/UserQueueTab')
#--------------------------------------------------------------------------------
require './UserBody.styl'
#--------------------------------------------------------------------------------

UserBody = React.createClass {

  displayName: 'UserBody'

  propTypes:
    user:    PropTypes.User
    profile: PropTypes.Profile

  render: ->

    TabBlock {className: 'card-body', selected: 'profile'},
      UserProfileTab {key: 'profile', title: 'Profile', user: @props.user, profile: @props.profile}
      #UserQueueTab   {key: 'queue',   title: 'Queue',   user: @props.user, profile: @props.profile}

}

module.exports = UserBody
