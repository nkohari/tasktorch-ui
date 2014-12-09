_            = require 'lodash'
React        = require 'react'
Format       = require 'framework/Format'
Observe      = require 'mixins/Observe'
WorkspaceUrl = require '../../WorkspaceUrl'
Icon         = React.createFactory(require 'common/Icon')
{div, span}  = React.DOM

StackHeader = React.createClass {

  displayName: 'StackHeader'

  mixins: [
    Observe('teams', 'users')
  ]

  getStateFromStores: (stores) ->
    return {
      currentUser: stores.users.getCurrentUser()
      owner: stores.users.getUser(@props.stack.owner) if @props.stack.owner?
      team:  stores.teams.getTeam(@props.stack.team)  if @props.stack.team?
    }

  isReady: ->
    @state.currentUser? and (@state.owner? or not @props.stack.owner?) and (@state.team? or not @props.stack.team?)

  render: ->
    children = if @isReady() then @renderChildren() else []
    div {className: 'header'}, children

  renderChildren: ->

    name = Format.stackName {
      stack: @props.stack
      owner: @state.owner
      team:  @state.team
      currentUser: @state.currentUser
    }

    return [
      Icon {key: 'icon', name: "stack-#{@props.stack.type.toLowerCase()}"}
      span {key: 'title', className: 'title'}, [name]
    ]

}

module.exports = StackHeader
