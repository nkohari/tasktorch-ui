React  = require 'react'
Button = React.createFactory(require 'ui/common/Button')
{div}  = React.DOM

StackFooter = React.createClass {

  displayName: 'StackFooter'

  render: ->
    div {className: 'footer'}, [
    ]

}

module.exports = StackFooter
