React          = require 'react'
Flux           = require '../../mixins/Flux'
PresenceWidget = React.createFactory(require './PresenceWidget')
{div}          = React.DOM

OrganizationWidget = React.createClass {

  displayName: 'OrganizationWidget'

  mixins: [
    Flux('organizations')
  ]

  getStateFromStores: (stores) ->
    return {
      organizations: stores.organizations.getAllOrganizations()
    }

  render: ->

    unless @props.currentOrganization?
      return div {className: 'organization loading'}

    div {className: 'organization'}, [
      div {key: 'name', className: 'organization-name'}, [@props.currentOrganization.name]
      PresenceWidget {key: 'presence'}
    ]

}

module.exports = OrganizationWidget
