React      = require 'react'
_          = require 'lodash'
UserWidget = require './UserWidget'
{div}      = React.DOM

PresenceBar = React.createClass {

  getInitialState: ->
    {connectedUsers: []}

  componentWillReceiveProps: (newProps) ->
    @bindPresenceEvents(newProps.channel) if newProps.channel?

  componentWillMount: ->
    @bindPresenceEvents(@props.channel) if @props.channel?

  render: ->
    users = _.map @state.connectedUsers, (user) -> UserWidget {user}
    div {className: 'presence'}, users

  bindPresenceEvents: (channel) ->
    channel.bind('pusher:subscription_succeeded',  @handlePresenceChange)
    channel.bind('pusher:member_added',            @handlePresenceChange)
    channel.bind('pusher:member_removed',          @handlePresenceChange)

  handlePresenceChange: ->
    connectedUsers = []
    @props.channel.members.each (member) -> connectedUsers.push(member.info)
    console.log(connectedUsers)
    @setState {connectedUsers}

}

module.exports = PresenceBar
