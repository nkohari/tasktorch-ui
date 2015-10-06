#--------------------------------------------------------------------------------
_                       = require 'lodash'
React                   = require 'react'
classSet                = require 'common/util/classSet'
UserToggledPanelEvent   = require 'events/ui/UserToggledPanelEvent'
PropTypes               = require 'ui/framework/PropTypes'
Actor                   = require 'ui/framework/mixins/Actor'
ViewContext             = require 'ui/framework/mixins/ViewContext'
BigPictureTeamPanelSpec = require 'ui/framework/panels/BigPictureTeamPanelSpec'
DrawerItem              = React.createFactory(require 'ui/common/DrawerItem')
#--------------------------------------------------------------------------------

TeamDrawerItem = React.createClass {

  displayName: 'TeamDrawerItem'

  propTypes:
    team: PropTypes.Team

  mixins: [Actor, ViewContext]

  render: ->

    classes = classSet [
      'team'
      'active' if @isPanelOpen(@props.team.id)
    ]

    DrawerItem {
      className: classes
      icon:      'team'
      label:     @props.team.name
      onClick:   @toggleTeam
    }   

  toggleTeam: ->
    @publish new UserToggledPanelEvent(new BigPictureTeamPanelSpec(@props.team.id))

}

module.exports = TeamDrawerItem
