_             = require 'lodash'
React         = require 'react'
Avatar        = React.createFactory(require 'common/Avatar')
{div, ul, li} = React.DOM

CardParticipants = React.createClass {

  displayName: 'CardParticipants'

  render: ->

    owner = _.find @props.participants, (user) => user.id == @props.card.owner.id
    sideline = _.map _.without(@props.participants, owner), (user) =>
      li {}, [
        Avatar {key: "user-#{user.id}", user, size: 32}
      ]

    div {className: 'participants'}, [
      div {className: 'owner group'}, [
        Avatar {key: 'owner', user: owner, size: 32}
        div {className: 'title'}, ['Owner']
      ]
      div {className: 'sidelines group'}, [
        ul {}, sideline
      ]
    ]

}

module.exports = CardParticipants
