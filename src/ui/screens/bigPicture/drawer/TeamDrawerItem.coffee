#--------------------------------------------------------------------------------
_              = require 'lodash'
React          = require 'react'
classSet       = require 'common/util/classSet'
PropTypes      = require 'ui/framework/PropTypes'
Navigator      = require 'ui/framework/mixins/Navigator'
TeamPanelState = require 'ui/screens/bigPicture/panels/team/TeamPanelState'
Icon           = React.createFactory(require 'ui/common/Icon')
Link           = React.createFactory(require 'ui/common/Link')
ListItem       = React.createFactory(require 'ui/common/ListItem')
{span}         = React.DOM
#--------------------------------------------------------------------------------

TeamDrawerItem = React.createClass {

  displayName: 'TeamDrawerItem'

  propTypes:
    team: PropTypes.Team

  mixins: [Navigator]

  render: ->

    classes = classSet [
      'drawer-item'
      'active' if @getScreen('bigpicture').isPanelVisible(@props.team.id)
    ]

    Link {className: classes, onClick: @toggleTeam},
      Icon {name: 'team'}
      span {className: 'name'}, @props.team.name

  toggleTeam: ->
    @getScreen('bigpicture').togglePanel(new TeamPanelState(@props.team.id))

}

module.exports = TeamDrawerItem
