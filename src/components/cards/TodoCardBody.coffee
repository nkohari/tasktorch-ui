React = require 'react'
{div} = React.DOM

TodoCardBody = React.createClass {

  render: ->
    div {className: 'stack-card-body'}, [@props.card.title]

}

module.exports = TodoCardBody
