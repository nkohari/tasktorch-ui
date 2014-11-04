React            = require 'react/addons'
ActiveUrl        = require '../mixins/ActiveUrl'
Flux             = require '../mixins/Flux'
ShellUrl         = require './ShellUrl'
ShellEnvironment = require './ShellEnvironment'
ShellHeader      = React.createFactory(require './components/ShellHeader')
{div}            = React.DOM

Shell = React.createClass {

  displayName: 'Shell'

  mixins: [
    ActiveUrl(ShellUrl)
    Flux('organizations', 'presence')
  ]

  getDefaultProps: ->
    {controller: ShellEnvironment.createController()}

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
    Screen = @props.activeRouteHandler
    div {className: 'shell'}, [
      ShellHeader {key: 'header', currentOrganization: @state.currentOrganization, currentUser: @state.currentUser}
      Screen {key: 'screen', currentOrganization: @state.currentOrganization, currentUser: @state.currentUser}
    ]

}

module.exports = Shell
