_                   = require 'lodash'
React               = require 'react'
Observe             = require 'mixins/Observe'
LoadMyStacksRequest = require 'requests/LoadMyStacksRequest'
SidebarItemGroup    = React.createFactory(require 'common/SidebarItemGroup')
SearchBox           = React.createFactory(require './SearchBox')
StackSidebarItem    = React.createFactory(require './StackSidebarItem')
{div, ul}           = React.DOM

WorkspaceSidebar = React.createClass {

  displayName: 'WorkspaceSidebar'

  mixins: [Observe('stacks')]

  getStateFromStores: (stores) ->
    return {
      stacks: stores.stacks.getAllStacks()
    }

  componentWillMount: ->
    @execute new LoadMyStacksRequest()

  render: ->

    myStacks = _.map @state.stacks, (stack) =>
      StackSidebarItem {key: "stack-#{stack.id}", stack}

    div {className: 'workspace sidebar panel'}, [
      SearchBox {key: 'search'}
      SidebarItemGroup {key: 'my-stacks', header: 'My Stacks'}, myStacks
    ]

}

module.exports = WorkspaceSidebar
