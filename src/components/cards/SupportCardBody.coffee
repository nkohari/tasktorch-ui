React = require 'react'
{div} = React.DOM

SupportCardBody = React.createClass {

  render: ->
    div {className: 'stack-card-body'}, [
      div {className: 'title'}, [@props.card.title]
      div {className: 'customer'} , ["Customer: #{@props.card.customer}"]
    ]

}

module.exports = SupportCardBody
