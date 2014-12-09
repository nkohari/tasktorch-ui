_                             = require 'lodash'
React                         = require 'react'
Observe                       = require 'mixins/Observe'
LoadParticipantsOnCardRequest = require 'requests/LoadParticipantsOnCardRequest'
Avatar                        = React.createFactory(require 'common/Avatar')
{div, span, ul, li}           = React.DOM

CardParticipants = React.createClass {

  displayName: 'CardParticipants'

  mixins: [Observe('users')]

  getStateFromStores: (stores) ->
    return {
      currentUser: stores.users.getCurrentUser()
      owner: stores.users.getUser(@props.card.owner) if @props.card.owner?
      participants: stores.users.getUsers(@props.card.participants)
    }

  componentWillMount: ->
    @execute new LoadParticipantsOnCardRequest(@props.card.id)

  isReady: ->
    @state.currentUser? and (@state.owner? or not @props.card.owner?) and @state.participants?

  render: ->
    children = if @isReady() then @renderChildren() else []
    ul {className: 'participants'}, children

  renderChildren: ->
    _.map @state.participants, (user) =>
      li {key: "user-#{user.id}", className: 'participant'}, [
        Avatar {key: 'avatar', user, size: 32}
      ] 

}

module.exports = CardParticipants
