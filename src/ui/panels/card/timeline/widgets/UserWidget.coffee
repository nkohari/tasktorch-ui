React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Avatar    = React.createFactory(require 'ui/common/Avatar')
{em}      = React.DOM

UserWidget = React.createClass {

  displayName: 'UserWidget'

  propTypes:
    user: PropTypes.User

  render: ->

    if @props.user?
      em {},
        Avatar {user: @props.user}
        @props.user.name
    else
      em {}, 'no one'

}

module.exports = UserWidget
