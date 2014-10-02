React = require 'react'
{div} = React.DOM

TaskCardBody = React.createClass {

  render: ->
    div {className: 'stack-card-body'}, [@props.card.title]

}

module.exports = TaskCardBody
