React = require 'react'
{div} = React.DOM

BugCardBody = React.createClass {

  render: ->
    div {className: 'stack-card-body'}, [@props.card.title]

}

module.exports = BugCardBody
