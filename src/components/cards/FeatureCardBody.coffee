React = require 'react'
{div} = React.DOM

FeatureCardBody = React.createClass {

  render: ->
    div {className: 'stack-card-body'}, [@props.card.title]

}

module.exports = FeatureCardBody
