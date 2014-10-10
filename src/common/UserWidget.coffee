_      = require 'lodash'
React  = require 'react'
Avatar = require './Avatar'
{div}  = React.DOM

UserWidget = React.createClass {

  render: ->
    div {className: 'user widget'}, [
      Avatar {user: @props.user, size: 32}
    ]

}

module.exports = UserWidget
