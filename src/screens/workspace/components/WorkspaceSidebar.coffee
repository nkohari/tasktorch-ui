React         = require 'react'
Flux          = require 'mixins/Flux'
List          = React.createFactory(require 'common/List')
Panel         = React.createFactory(require 'common/Panel')
SearchBox     = React.createFactory(require './SearchBox')
StackListItem = React.createFactory(require './StackListItem')
{div}         = React.DOM

WorkspaceSidebar = React.createClass {

  displayName: 'WorkspaceSidebar'

  mixins: [Flux('stacks')]

  getStateFromStores: (stores) ->
    return {
      stacks: stores.stacks.getAllStacks()
    }

  render: ->
    div {className: 'workspace sidebar'}, [
      SearchBox {key: 'search'}
      List {key: 'stack-list', className: 'stack-list', component: StackListItem, kind: 'stack', items: @state.stacks}
    ]

}

module.exports = WorkspaceSidebar
