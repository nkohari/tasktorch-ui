_             = require 'lodash'
React         = require 'react'
PropTypes     = require 'ui/framework/PropTypes'
Frame         = React.createFactory(require 'ui/common/Frame')
MyStackList   = React.createFactory(require 'ui/screens/workspace/drawer/MyStackList')
TeamStackList = React.createFactory(require 'ui/screens/workspace/drawer/TeamStackList')

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
