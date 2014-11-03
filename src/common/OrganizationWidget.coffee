React          = require 'react'
Flux           = require '../mixins/Flux'
PresenceWidget = React.createFactory(require './PresenceWidget')
{div}          = React.DOM

OrganizationWidget = React.createClass {

  mixins: [Flux()]

  displayName: 'OrganizationWidget'

  render: ->
    div {className: 'organization widget'}, [
      div {className: 'organization-name'}, [@props.organization.name]
      PresenceWidget {}
    ]
}

module.exports = OrganizationWidget
