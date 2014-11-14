_                = require 'lodash'
React            = require 'react'
Router           = require 'react-router'
Format           = require 'framework/Format'
Observe          = require 'mixins/Observe'
ActiveUrl        = require 'mixins/ActiveUrl'
WorkspaceUrl     = require '../WorkspaceUrl'
LoadStackRequest = require 'requests/LoadStackRequest'
Icon             = React.createFactory(require 'common/Icon')
Link             = React.createFactory(Router.Link)
{div}            = React.DOM

CardLocation = React.createClass {

  displayName: 'CardLocation'

  mixins: [
    Observe('stacks', 'teams', 'users')
    ActiveUrl(WorkspaceUrl)
  ]

  getStateFromStores: (stores) ->
    currentUser = stores.users.getCurrentUser()
    stack = stores.stacks.getStack(@props.stackId)
    if stack?
      owner = stores.users.getUser(stack.owner.id) if stack.owner?
      team = stores.teams.getTeam(stack.team.id) if stack.team?
    {currentUser, stack, owner, team}

  componentWillMount: ->
    @execute new LoadStackRequest(@props.stackId)

  isReady: ->
    @state.stack? and @state.currentUser? and (@state.owner? or not @state.stack.owner?) and (@state.team? or not @state.stack.team?)

  render: ->
    children = if @isReady() then @renderChildren() else []
    div {className: 'location aspect'}, children

  renderChildren: ->
    name = Format.stackName {
      stack: @state.stack
      owner: @state.owner
      team:  @state.team
      currentUser: @state.currentUser
    }
    props = _.extend {key: 'link'}, @makeStackLinkProps()
    return [
      Link props, [
        Icon {key: 'icon', name: "stack-#{@state.stack.type.toLowerCase()}"}
        name
      ]
    ]

  makeStackLinkProps: ->
    url = @getActiveUrl()
    url.addStack(@props.stackId)
    return url.makeLinkProps()

}

module.exports = CardLocation
