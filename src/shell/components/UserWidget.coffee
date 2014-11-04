_      = require 'lodash'
React  = require 'react'
Avatar = React.createFactory(require '../../common/Avatar')
{div}  = React.DOM

UserWidget = React.createClass {

  displayName: 'UserWidget'

  render: ->

    unless @props.currentUser?
      return div {className: 'user loading'}

    div {className: 'user'}, [
      Avatar {key: 'user-avatar', user: @props.currentUser, size: 32}
    ]

}

module.exports = UserWidget
