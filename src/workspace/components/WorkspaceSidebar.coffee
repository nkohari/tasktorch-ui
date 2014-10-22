React     = require 'react'
Panel     = require '../../common/Panel'
StackList = require './StackList'
{div}     = React.DOM

WorkspaceSidebar = React.createClass {

  render: ->
    div {className: 'workspace sidebar'}, [
      StackList {stacks: @props.stacks, teams: @props.teams}
    ]

}

module.exports = WorkspaceSidebar
