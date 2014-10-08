crypto = require 'crypto'
React  = require 'react'
{img}  = React.DOM

Avatar = React.createClass {

  getDefaultProps: ->
    {user: undefined, size: 48}

  render: ->
    img {className: "avatar", src: @getImageUrl(), alt: @props.user.name}, []

  getImageUrl: ->
    hash = crypto.createHash('md5').update(@props.user.emails[0]).digest('hex')
    return "https://www.gravatar.com/avatar/#{hash}?s=#{@props.size}"

}

module.exports = Avatar
