React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Avatar    = React.createFactory(require 'ui/common/Avatar')
{div}     = React.DOM

UserSelectorOption = React.createClass {

  displayName: 'UserSelectorOption'

  propTypes:
    value: PropTypes.User

  render: ->

    div {},
      Avatar {user: @props.value}
      @props.value.name

}

module.exports = UserSelectorOption
