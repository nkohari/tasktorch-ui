PropTypes = require 'ui/framework/PropTypes'

ShellContext = {

  contextTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  getCurrentOrg: ->
    @context.currentOrg

  getCurrentUser: ->
    @context.currentUser

}

module.exports = ShellContext
