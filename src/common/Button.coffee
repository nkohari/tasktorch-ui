_     = require 'lodash'
React = require 'react'
Icon  = React.createFactory(require './Icon')
{span, button} = React.DOM

Button = React.createClass {

  displayName: 'Button'

  render: ->
    props = _.omit(@props, 'icon', 'text')
    button props, _.compact [
      Icon {key: 'icon', name: @props.icon} if @props.icon?
      span {key: 'text'}, @props.text
    ]

}

module.exports = Button
