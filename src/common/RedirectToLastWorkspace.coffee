React = require 'react'

RedirectToLastWorkspace = React.createClass {

  statics:

    willTransitionTo: (transition, params, query) ->
      # TODO: Read last organization ID from cookie/session
      transition.redirect('workspace', {organizationId: '1'}, {})

  render: ->
    null

}

module.exports = RedirectToLastWorkspace
