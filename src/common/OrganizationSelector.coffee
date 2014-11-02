React = require 'react'
{div} = React.DOM

OrganizationSelector = React.createClass {

  displayName: 'OrganizationSelector'

  render: ->
    div {className: "organization widget"}, [@props.organization.name]

}

module.exports = OrganizationSelector
