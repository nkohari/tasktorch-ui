_                = require 'lodash'
React            = require 'react'
Observe          = require 'mixins/Observe'
StackSidebarItem = React.createFactory(require './StackSidebarItem')
{div, ul}        = React.DOM

TeamStackList = React.createClass {

  displayName: 'TeamStackList'

  mixins: [Observe('stacks')]

  getStateFromStores: (stores) ->
    {stacks: stores.stacks.getStacksByTeam(@props.team.id)}

  isReady: ->
    @state.stacks?

  render: ->
    children = if @isReady() then @renderChildren() else []
    div {className: 'team group'}, children

  renderChildren: ->

    stacks = _.map @state.stacks, (stack) =>
      StackSidebarItem {key: "stack-#{stack.id}", stack}

    return [
      div {key: 'header', className: 'header'}, [@props.team.name]
      ul {key: 'items'}, stacks
    ]

}

module.exports = TeamStackList
