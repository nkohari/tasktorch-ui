React  = require 'react'
Button = React.createFactory(require 'common/Button')
{div}  = React.DOM

StackFooter = React.createClass {

  displayName: 'StackFooter'

  render: ->
    div {className: 'footer'}, [
      div {className: 'button-group right'}, [
        Button {key: 'create-card', icon: 'create-card'}
      ]
    ]

}

module.exports = StackFooter
