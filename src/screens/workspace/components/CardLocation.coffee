_                = require 'lodash'
React            = require 'react'
Router           = require 'react-router'
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

  render: ->

    unless @state.stack? and @state.owner?
      return div {className: 'location loading'}, []

    props = _.extend {key: 'link'}, @makeStackLinkProps()
    div {className: 'location aspect'}, [
      div {key: 'name', className: 'name'}, ['Stack']
      div {key: 'value', className: 'value'}, [
        Link props, [
          Icon {key: 'icon', name: "stack-#{@state.stack.kind.toLowerCase()}"}
          @formatStackName()
        ]
      ]
    ]

  # TODO: Support teams, and make it say "My Queue" if it's the current user
  formatStackName: ->
    if @state.owner?.id == @state.currentUser.id
      name = 'My'
    else
      name = "#{@state.owner.name}'s"
    switch @state.stack.kind
      when 'Queue'
        return "#{name} Queue"
      when 'Inbox'
        return "#{name} Inbox"
      else
        return @state.stack.name

  makeStackLinkProps: ->
    url = @getActiveUrl()
    url.addStack(@props.stackId)
    return url.makeLinkProps()

}

module.exports = CardLocation
