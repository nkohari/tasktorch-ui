_      = require 'lodash'
React  = require 'react'
Avatar = React.createFactory(require './Avatar')
{div}  = React.DOM

UserWidget = React.createClass {

  displayName: 'UserWidget'

  render: ->
    div {className: 'user widget'}, [
      Avatar {key: 'user-avatar', user: @props.user, size: 32}
    ]

}

module.exports = UserWidget
