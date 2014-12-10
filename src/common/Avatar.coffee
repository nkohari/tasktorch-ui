React          = require 'react'
{div, img}     = React.DOM
Tooltip        = React.createFactory(require './Tooltip')
OverlayTrigger = React.createFactory(require './OverlayTrigger')

Avatar = React.createClass {

  displayName: 'Avatar'

  render: ->

    if @props.className?
      classes = @props.className.split(/\s+/).concat('avatar').join(' ')
    else
      classes = 'avatar'

    overlay = Tooltip {text: @props.user.name}
    OverlayTrigger {placement: 'top', trigger: 'click', transition: 'slide', overlay},
      img {className: classes, src: @props.user.avatarUrl}

}

module.exports = Avatar
