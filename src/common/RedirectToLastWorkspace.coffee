React = require 'react'

RedirectToLastWorkspace = React.createClass {

  statics:

    willTransitionTo: (transition, params, query) ->
      # TODO: Read last organization ID from cookie/session
      transition.redirect('workspace', {organizationId: '1'}, {})

  displayName: 'RedirectToLastWorkspace'

  render: ->
    null

}

module.exports = RedirectToLastWorkspace
