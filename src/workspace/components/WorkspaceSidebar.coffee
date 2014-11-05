React     = require 'react'
Flux      = require '../../mixins/Flux'
Panel     = React.createFactory(require '../../common/Panel')
SearchBox = React.createFactory(require './SearchBox')
StackList = React.createFactory(require './StackList')
{div}     = React.DOM

WorkspaceSidebar = React.createClass {

  displayName: 'WorkspaceSidebar'

  mixins: [Flux()]

  render: ->
    div {className: 'workspace sidebar'}, [
      SearchBox {key: 'search'}
      StackList {key: 'stack-list', stacks: @props.stacks, teams: @props.teams}
    ]

}

module.exports = WorkspaceSidebar
