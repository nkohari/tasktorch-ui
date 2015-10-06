#--------------------------------------------------------------------------------
_                   = require 'lodash'
React               = require 'react'
UserChangedBioEvent = require 'events/ui/UserChangedBioEvent'
PropTypes           = require 'ui/framework/PropTypes'
Actor               = require 'ui/framework/mixins/Actor'
CachedState         = require 'ui/framework/mixins/CachedState'
IdentityContext     = require 'ui/framework/mixins/IdentityContext'
Icon                = React.createFactory(require 'ui/common/Icon')
EditableTextArea    = React.createFactory(require 'ui/common/EditableTextArea')
PanelSection        = React.createFactory(require 'ui/common/PanelSection')
UserTeamRow         = React.createFactory(require 'ui/screens/workspace/panels/user/UserTeamRow')
{div}               = React.DOM
#--------------------------------------------------------------------------------
require './UserProfileTab.styl'
#--------------------------------------------------------------------------------

UserProfileTab = React.createClass {

  displayName: 'UserProfileTab'

  propTypes:
    user:    PropTypes.User
    profile: PropTypes.Profile

  mixins: [Actor, CachedState, IdentityContext]

  getCachedState: (cache) -> {
    teams: cache('teamsByUser').get(@props.user.id)
  }

  render: ->

    teams = _.map @state.teams, (team) =>
      UserTeamRow {team}

    div {className: 'user-profile-tab'},
      PanelSection {icon: 'info', title: 'About Me'},
        @renderBio()
      PanelSection {icon: 'team', title: 'My Teams'},
        teams

  renderBio: ->
    if @props.user.id == @getCurrentUser().id
      EditableTextArea {className: 'user-bio', rows: 1, placeholder: 'Tell everyone a little about yourself!', value: @props.profile.bio, save: @changeBio}
    else
      div {className: 'user-bio'}, @props.profile.bio

  changeBio: (bio) ->
    @publish new UserChangedBioEvent(bio)

}

module.exports = UserProfileTab
