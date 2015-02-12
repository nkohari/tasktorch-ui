_             = require 'lodash'
React         = require 'react'
Observe       = require 'framework/mixins/Observe'
PropTypes     = require 'framework/PropTypes'
Frame         = React.createFactory(require 'ui/common/Frame')
MyStackList   = React.createFactory(require 'ui/screens/workspace/sidebar/MyStackList')
TeamStackList = React.createFactory(require 'ui/screens/workspace/sidebar/TeamStackList')

StackBrowser = React.createClass {

  displayName: 'StackBrowser'

  propTypes:
    currentUser: PropTypes.User
    stacks:      PropTypes.arrayOf(PropTypes.Stack)
    teams:       PropTypes.arrayOf(PropTypes.Team)

  render: ->

    myStacks = MyStackList {key: 'me', stacks: @props.stacks}
    teamStacks = _.map @props.teams, (team) =>
      TeamStackList {key: "team-#{team.id}", team}

    Frame {className: 'stacks'}, [myStacks].concat(teamStacks)
      
}

module.exports = StackBrowser
