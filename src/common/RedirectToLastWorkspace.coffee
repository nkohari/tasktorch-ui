React = require 'react'

RedirectToLastWorkspace = React.createClass {

  statics:

    willTransitionTo: (transition, params, query) ->
      # TODO: Read last org ID from cookie/session
      transition.redirect('workspace', {orgId: '1'}, {})

  displayName: 'RedirectToLastWorkspace'

  render: ->
    null

}

module.exports = RedirectToLastWorkspace
