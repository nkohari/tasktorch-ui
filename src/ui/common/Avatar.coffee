React      = require 'react'
PropTypes  = require 'framework/PropTypes'
mergeProps = require 'util/mergeProps'
{img}      = React.DOM

Avatar = React.createClass {

  displayName: 'Avatar'

  propTypes:
    user: PropTypes.User

  render: ->

    props = mergeProps @props, {
      className: 'avatar'
      src:       @props.user.avatarUrl
    }

    img props

}

module.exports = Avatar
