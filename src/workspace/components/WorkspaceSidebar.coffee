React     = require 'react'
Panel     = React.createFactory(require '../../common/Panel')
StackList = React.createFactory(require './StackList')
{div}     = React.DOM

WorkspaceSidebar = React.createClass {

  displayName: 'WorkspaceSidebar'

  render: ->
    Panel {panelTitle: 'Stacks', className: 'workspace sidebar'}, [
      StackList {key: 'stack-list', stacks: @props.stacks, teams: @props.teams}
    ]

}

module.exports = WorkspaceSidebar
