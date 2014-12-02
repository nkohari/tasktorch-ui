React          = require 'react'
{div, img}     = React.DOM
Tooltip        = React.createFactory(require './Tooltip')
OverlayTrigger = React.createFactory(require './OverlayTrigger')

Avatar = React.createClass {

  displayName: 'Avatar'

  render: ->
    overlay = Tooltip {className: 'overlay', text: @props.user.name}

    OverlayTrigger {placement: 'right', trigger: 'click', overlay},
      img {key: 'image', className: 'avatar', src: @props.user.avatarUrl}

}

module.exports = Avatar
