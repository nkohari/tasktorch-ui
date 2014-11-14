_            = require 'lodash'
React        = require 'react'
Router       = require 'react-router'
Format       = require 'framework/Format'
ActiveUrl    = require 'mixins/ActiveUrl'
Observe      = require 'mixins/Observe'
WorkspaceUrl = require '../WorkspaceUrl'
Icon         = React.createFactory(require 'common/Icon')
Link         = React.createFactory(Router.Link)
{div, span}  = React.DOM

StackHeader = React.createClass {

  displayName: 'StackHeader'

  mixins: [
    Observe('teams', 'users')
    ActiveUrl(WorkspaceUrl)
  ]

  getStateFromStores: (stores) ->
    return {
      currentUser: stores.users.getCurrentUser()
      owner: stores.users.getUser(@props.stack.owner.id) if @props.stack.owner?
      team:  stores.teams.getTeam(@props.stack.team.id)  if @props.stack.team?
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
      span {key: 'title', name: 'title'}, [name]
      @makeCloseLink()
    ]

  makeCloseLink: ->
    url = @getActiveUrl()
    url.removeStack(@props.stack.id)
    props = _.extend {key: 'close', className: 'close'}, url.makeLinkProps()
    Link props, [
      Icon {key: 'close', name: 'close'}
    ]

}

module.exports = StackHeader
