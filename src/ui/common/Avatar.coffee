#--------------------------------------------------------------------------------
React       = require 'react'
md5         = require 'blueimp-md5'
classSet    = require 'common/util/classSet'
mergeProps  = require 'common/util/mergeProps'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
mergeProps  = require 'common/util/mergeProps'
{img}       = React.DOM
#--------------------------------------------------------------------------------
require './Avatar.styl'
#--------------------------------------------------------------------------------

Avatar = React.createClass {

  displayName: 'Avatar'

  propTypes:
    user:  PropTypes.User
    email: PropTypes.string
    size:  PropTypes.number

  mixins: [CachedState]

  getDefaultProps: -> {
    size: 24
    presence: false
  }

  getCachedState: (cache) -> {
    isOnline: cache('onlineUsers').has(@props.user?.id)
  }

  render: ->

    props = mergeProps _.omit(@props, 'user', 'email'), {
      height: @props.size
      width: @props.size
      className: classSet [
        'avatar'
        'presence' if @props.presence
        'online'   if @props.presence and @state.isOnline
      ]
    }

    if @props.user?
      props.src   = @props.user.avatarUrl
      props.title = @props.user.name
    else if @props.email?
      props.src   = "https://www.gravatar.com/avatar/#{md5(@props.email)}?rating=g&d=identicon"
      props.title = @props.email

    img props

}

module.exports = Avatar
