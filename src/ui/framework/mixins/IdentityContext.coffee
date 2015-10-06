PropTypes = require 'ui/framework/PropTypes'

IdentityContext = {

  contextTypes:
    currentOrg:  PropTypes.Org
    currentUser: PropTypes.User

  getCurrentOrg: ->
    @context.currentOrg

  getCurrentUser: ->
    @context.currentUser

}

module.exports = IdentityContext
