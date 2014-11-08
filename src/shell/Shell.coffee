React                  = require 'react/addons'
ActiveUrl              = require 'mixins/ActiveUrl'
Flux                   = require 'mixins/Flux'
ShellUrl               = require './ShellUrl'
ShellControllerFactory = require './ShellControllerFactory'
ShellHeader            = React.createFactory(require './components/ShellHeader')
{div}                  = React.DOM

Shell = React.createClass {

  displayName: 'Shell'

  mixins: [
    ActiveUrl(ShellUrl)
    Flux('organizations', 'presence')
  ]

  getDefaultProps: ->
    {controller: ShellControllerFactory.create()}

  # TODO: Could we remove ActiveUrl and just set organizationId as a prop?

  getStateFromStores: (stores) ->
    return {
      currentUser:         stores.presence.currentUser
      currentOrganization: stores.organizations.getOrganization(@getActiveUrl().organizationId)
    }

  componentWillMount: ->
    controller = @getController()
    controller.setCurrentOrganization(@getActiveUrl().organizationId)
    controller.loadCurrentUser()
    controller.loadMyOrganizations()

  render: ->

    unless @state.currentUser? and @state.currentOrganization?
      return div {className: 'shell loading'}, []

    Screen = @props.activeRouteHandler
    div {className: 'shell'}, [
      ShellHeader {key: 'header', currentOrganization: @state.currentOrganization, currentUser: @state.currentUser}
      Screen {key: 'screen', currentOrganization: @state.currentOrganization, currentUser: @state.currentUser}
    ]

}

module.exports = Shell
