React       = require 'react'
ActiveUrl   = require '../mixins/ActiveUrl'
Flux        = require '../mixins/Flux'
ShellUrl    = require './ShellUrl'
ShellHeader = React.createFactory(require './ShellHeader')

Shell = React.createClass {

  displayName: 'Shell'

  mixins: [
    ActiveUrl(ShellUrl)
    Flux('organizations', 'users')
  ]

  getStateFromStores: (stores) ->
    return {
      currentUser:         stores.users.currentUser
      currentOrganization: stores.organizations.currentOrganization
    }

  render: ->
    ShellHeader {currentOrganization: @state.currentOrganization, currentUser: @state.currentUser}, [
      @props.activeRouteHandler
    ]

}

module.exports = Shell
