React          = require 'react'
{div, img}     = React.DOM
Tooltip        = React.createFactory(require './Tooltip')
OverlayTrigger = React.createFactory(require './OverlayTrigger')

Avatar = React.createClass {

  displayName: 'Avatar'

  render: ->
    overlay = Tooltip {text: @props.user.name}
    OverlayTrigger {placement: 'top', trigger: 'click', overlay},
      img {className: 'avatar', src: @props.user.avatarUrl}

}

module.exports = Avatar
