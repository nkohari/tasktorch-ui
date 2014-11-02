React     = require 'react'
StackList = React.createFactory(require './StackList')
{div}     = React.DOM

WorkspaceSidebar = React.createClass {

  displayName: 'WorkspaceSidebar'

  render: ->
    div {className: 'workspace sidebar'}, [
      StackList {key: 'stack-list', stacks: @props.stacks, teams: @props.teams}
    ]

}

module.exports = WorkspaceSidebar
