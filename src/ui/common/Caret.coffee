React  = require 'react'
{span} = React.DOM

Caret = React.createClass {

  displayName: 'Caret'

  render: ->
    span {className: 'caret'}

}

module.exports = Caret
