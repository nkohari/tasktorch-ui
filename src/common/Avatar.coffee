crypto = require 'crypto'
React  = require 'react'
{img}  = React.DOM

Avatar = React.createClass {

  getDefaultProps: ->
    {user: undefined, size: 48}

  render: ->
    img {className: "avatar", src: @getImageUrl(), alt: @props.user.name}, []

  getImageUrl: ->
    return "#{@props.user.avatarUrl}?s=#{@props.size}"

}

module.exports = Avatar
