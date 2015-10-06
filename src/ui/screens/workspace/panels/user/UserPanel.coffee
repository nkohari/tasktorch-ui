#--------------------------------------------------------------------------------
_           = require 'lodash'
React       = require 'react'
mergeProps  = require 'common/util/mergeProps'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
Panel       = React.createFactory(require 'ui/common/Panel')
PanelHeader = React.createFactory(require 'ui/common/PanelHeader')
UserSummary = React.createFactory(require 'ui/screens/workspace/panels/user/UserSummary')
UserBody    = React.createFactory(require 'ui/screens/workspace/panels/user/UserBody')
UserFooter  = React.createFactory(require 'ui/screens/workspace/panels/user/UserFooter')
{div}       = React.DOM
#--------------------------------------------------------------------------------
require './UserPanel.styl'
#--------------------------------------------------------------------------------

UserPanel = React.createClass {

  displayName: 'UserPanel'

  propTypes:
    id: PropTypes.id

  mixins: [CachedState]

  getCachedState: (cache) -> {
    user: cache('users').get(@props.id)
    profile: cache('profiles').get(@props.id)
    isOnline: cache('onlineUsers').has(@props.id)
  }

  isReady: ->
    @state.user? and @state.profile?

  render: ->

    props = mergeProps @props, {
      className: 'user'
      @isReady
    }
    
    Panel props,
      PanelHeader {panelid: @props.id, icon: 'user'},
        @state.user?.name
      div {className: 'content'},
        UserSummary {user: @state.user, profile: @state.profile}
        UserBody {user: @state.user, profile: @state.profile}
      UserFooter {user: @state.user}

}

module.exports = UserPanel
