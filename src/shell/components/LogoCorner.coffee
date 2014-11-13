React = require 'react'
{div, ul, li, a} = React.DOM

LogoCorner = React.createClass {

  displayName: 'LogoCorner'

  render: ->

    div {className: 'logo-corner'}, [
      ul {className: 'links'}, [
        li {}, [
          a {href: '#'}, ['Get Help']
        ]
        li {}, [
          a {href: '#'}, ['Contact Us']
        ]
      ]
    ]

}

module.exports = LogoCorner
