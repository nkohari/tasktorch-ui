#--------------------------------------------------------------------------------
React      = require 'react'
md5        = require 'blueimp-md5'
PropTypes  = require 'ui/framework/PropTypes'
mergeProps = require 'common/util/mergeProps'
{img}      = React.DOM
#--------------------------------------------------------------------------------

Avatar = React.createClass {

  displayName: 'Avatar'

  propTypes:
    user:  PropTypes.User
    email: PropTypes.string

  render: ->

    props = {className: 'avatar'}

    if @props.user?
      props.src   = @props.user.avatarUrl
      props.title = @props.user.name
    else if @props.email?
      props.src   = "https://www.gravatar.com/avatar/#{md5(@props.email)}?rating=g&d=identicon"
      props.title = @props.email

    props = mergeProps(@props, props)
    img props

}

module.exports = Avatar
