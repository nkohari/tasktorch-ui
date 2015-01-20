React     = require 'react'
PropTypes = require 'common/PropTypes'
Avatar    = React.createFactory(require 'common/Avatar')
{div}     = React.DOM

UserSelectorOption = React.createClass {

  displayName: 'UserSelectorOption'

  propTypes:
    value: PropTypes.User

  render: ->
    div {}, [
      Avatar {key: 'avatar', user: @props.value}
      @props.value.name
    ]

}

module.exports = UserSelectorOption
