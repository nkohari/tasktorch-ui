PropTypes = require 'ui/framework/PropTypes'

CurrentUserAware = {

  contextTypes:
    currentUser: PropTypes.User

  getCurrentUser: ->
    @context.currentUser

}

module.exports = CurrentUserAware
