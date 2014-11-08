_              = require 'lodash'
React          = require 'react'
Flux           = require 'mixins/Flux'
Panel          = React.createFactory(require 'common/Panel')
SidebarSection = React.createFactory(require 'common/SidebarSection')
SearchBox      = React.createFactory(require './SearchBox')
StackListItem  = React.createFactory(require './StackListItem')
{div, ul}      = React.DOM

WorkspaceSidebar = React.createClass {

  displayName: 'WorkspaceSidebar'

  mixins: [Flux('stacks')]

  getStateFromStores: (stores) ->
    return {
      stacks: stores.stacks.getAllStacks()
    }

  render: ->

    myStacks = _.map @state.stacks, (stack) =>
      StackListItem {key: "stack-#{stack.id}", stack}

    div {className: 'workspace sidebar'}, [
      SearchBox {key: 'search'}
      SidebarSection {key: 'my-stacks', header: 'My Stacks'}, myStacks
    ]

}

module.exports = WorkspaceSidebar
