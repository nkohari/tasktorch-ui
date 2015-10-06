#--------------------------------------------------------------------------------
_      = require 'lodash'
React  = require 'react'
Router = require 'react-router'
Banner = React.createFactory(require 'ui/common/Banner')
{a, p} = React.DOM
#--------------------------------------------------------------------------------

NotFoundBanner = React.createClass {

  displayName: 'NotFoundBanner'

  mixins: [Router.History]

  render: ->

    Banner {title: 'Not Found'},
      p {className: 'status-code'}, '404'
      p {},
        "Sorry, I couldn't find what you're looking for."
      p {},
        a {onClick: @goBackClicked}, "Back to log in"

  goBackClicked: ->
    @history.pushState(null, '/x/login')

}

module.exports = NotFoundBanner
