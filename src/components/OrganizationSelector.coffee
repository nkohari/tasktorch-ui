React = require 'react'
{div} = React.DOM

OrganizationSelector = React.createClass {

  render: ->
    div {className: "organization widget"}, [@props.organization.name]

}

module.exports = OrganizationSelector
