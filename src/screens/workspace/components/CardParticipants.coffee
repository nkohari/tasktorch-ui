_      = require 'lodash'
React  = require 'react'
Avatar = React.createFactory(require 'common/Avatar')
{div, span, ul, li} = React.DOM

CardParticipants = React.createClass {

  displayName: 'CardParticipants'

  render: ->

    owner = _.find @props.participants, (user) => user.id == @props.card.owner.id
    users = _.map @props.participants, (user) =>
      li {}, [
        Avatar {key: "user-#{user.id}", user, size: 18}
        if user.id == @props.currentUser.id then 'Me' else user.name
      ]

    div {className: 'participants aspect'}, [
      div {key: 'name', className: 'name'}, ['Participants']
      div {key: 'value', className: 'value'}, [
        ul {key: 'users'}, users
      ]
    ]

}

module.exports = CardParticipants
