#--------------------------------------------------------------------------------
_              = require 'lodash'
React          = require 'react'
classSet       = require 'common/util/classSet'
PropTypes      = require 'ui/framework/PropTypes'
Navigator      = require 'ui/framework/mixins/Navigator'
TeamPanelState = require 'ui/screens/bigPicture/panels/team/TeamPanelState'
DrawerItem     = React.createFactory(require 'ui/common/DrawerItem')
#--------------------------------------------------------------------------------

TeamDrawerItem = React.createClass {

  displayName: 'TeamDrawerItem'

  propTypes:
    team: PropTypes.Team

  mixins: [Navigator]

  render: ->

    classes = classSet [
      'team'
      'active' if @getScreen('bigpicture').isPanelVisible(@props.team.id)
    ]

    DrawerItem {
      className: classes
      icon:      'team'
      label:     @props.team.name
      onClick:   @toggleTeam
    }   

  toggleTeam: ->
    @getScreen('bigpicture').togglePanel(new TeamPanelState(@props.team.id))

}

module.exports = TeamDrawerItem
