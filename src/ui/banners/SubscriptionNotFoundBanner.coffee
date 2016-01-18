#--------------------------------------------------------------------------------
_      = require 'lodash'
React  = require 'react'
Router = require 'react-router'
Banner = React.createFactory(require 'ui/common/Banner')
{a, p} = React.DOM
#--------------------------------------------------------------------------------

SubscriptionNotFoundBanner = React.createClass {

  displayName: 'SubscriptionNotFoundBanner'

  mixins: [Router.History]

  render: ->

    Banner {title: 'Subscription Not Found'},
      p {className: 'status-code'}, '402'
      p {},
        "Sorry, this organization's subscription has expired or was canceled. Please contact "
        "the administrator of the organization to re-enable it."
      p {},
        "If you need assistance or believe you've received this message in error, please contact us at "
        a {href: "mailto:support@tasktorch.com"}, "support@tasktorch.com"
        "."
      p {},
        "You may also "
        a {onClick: @selectOrgClicked}, "switch to another organization"
        "."

  selectOrgClicked: ->
    @history.pushState(null, '/orgs')

}

module.exports = SubscriptionNotFoundBanner
