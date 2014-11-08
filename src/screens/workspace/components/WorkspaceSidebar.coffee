_                = require 'lodash'
React            = require 'react'
Flux             = require 'mixins/Flux'
Panel            = React.createFactory(require 'common/Panel')
SidebarItemGroup = React.createFactory(require 'common/SidebarItemGroup')
SearchBox        = React.createFactory(require './SearchBox')
StackSidebarItem = React.createFactory(require './StackSidebarItem')
{div, ul}        = React.DOM

WorkspaceSidebar = React.createClass {

  displayName: 'WorkspaceSidebar'

  mixins: [Flux('stacks')]

  getStateFromStores: (stores) ->
    return {
      stacks: stores.stacks.getAllStacks()
    }

  render: ->

    myStacks = _.map @state.stacks, (stack) =>
      StackSidebarItem {key: "stack-#{stack.id}", stack}

    div {className: 'workspace sidebar'}, [
      SearchBox {key: 'search'}
      SidebarItemGroup {key: 'my-stacks', header: 'My Stacks'}, myStacks
    ]

}

module.exports = WorkspaceSidebar
