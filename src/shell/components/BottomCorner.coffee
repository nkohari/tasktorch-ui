React = require 'react'
{a, div, img, span} = React.DOM

BottomCorner = React.createClass {

  displayName: 'BottomCorner'

  render: ->
    div {className: 'bottom corner'}, [
      div {key: 'links', className: 'links'}, [
        a {key: 'help', href: '/'}, ['Help']
        a {key: 'contact', href: '/'}, ['Contact']
      ]
      div {key: 'logo', className: 'logo'}, [
        span {key: 'first', className: 'first'}, ['Task']
        span {key: 'second', className: 'second'}, ['Torch']
      ]
    ]

}

module.exports = BottomCorner
