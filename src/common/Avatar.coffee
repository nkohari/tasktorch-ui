React      = require 'react'
PropTypes  = require 'common/PropTypes'
mergeProps = require 'common/util/mergeProps'
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
