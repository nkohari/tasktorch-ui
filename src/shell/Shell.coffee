React                  = require 'react/addons'
Flux                   = require 'mixins/Flux'
ShellControllerFactory = require './ShellControllerFactory'
ShellHeader            = React.createFactory(require './components/ShellHeader')
{div}                  = React.DOM

Shell = React.createClass {

  displayName: 'Shell'

  mixins: [
    Flux('organizations', 'presence')
  ]

  createController: ->
    ShellControllerFactory.create(@props.params.organizationId, @props.eventBus)

  getStateFromStores: (stores) ->
    return {
      currentUser:         stores.presence.currentUser
      currentOrganization: stores.organizations.getOrganization(@props.params.organizationId)
    }

  componentWillMount: ->
    controller = @getController()
    controller.loadCurrentUser()
    controller.loadMyOrganizations()

  render: ->

    unless @state.currentUser? and @state.currentOrganization?
      return div {className: 'shell loading'}, []

    Screen = @props.activeRouteHandler
    div {className: 'shell'}, [
      ShellHeader {key: 'header', currentOrganization: @state.currentOrganization, currentUser: @state.currentUser}
      Screen {key: 'screen'}
    ]

}

module.exports = Shell
