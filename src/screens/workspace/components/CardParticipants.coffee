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
      owner: stores.users.getUser(@props.card.owner.id) if @props.card.owner?
      participants: stores.users.getUsers(_.pluck(@props.card.participants, 'id'))
    }

  componentWillMount: ->
    @execute new LoadParticipantsOnCardRequest(@props.card.id)

  render: ->

    unless @state.currentUser? and @state.participants?
      return div {className: 'participants aspect loading'}, []

    users = _.map @state.participants, (user) =>
      li {key: "user-#{user.id}"}, [
        Avatar {key: 'avatar', user, size: 18}
        if user.id == @state.currentUser.id then 'Me' else user.name
      ]

    div {className: 'participants aspect'}, [
      div {key: 'name', className: 'name'}, ['Participants']
      div {key: 'value', className: 'value'}, [
        ul {key: 'users'}, users
      ]
    ]

}

module.exports = CardParticipants
