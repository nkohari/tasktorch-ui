#--------------------------------------------------------------------------------
React     = require 'react/addons'
PropTypes = require 'ui/framework/PropTypes'
Callout   = React.createFactory(require 'ui/walkthrough/Callout')
{p, em}   = React.DOM
#--------------------------------------------------------------------------------

OrgMenuCallout = React.createClass {

  displayName: 'OrgMenuCallout'

  render: ->

    Callout {selector: '.org.menu-button', position: 'below right', forceSize: false},
      p {},
        "One last thing and then you can start working in TaskTorch! If you want to create card kinds, "
        "create teams, and invite more people to work with you, you can click here."
      p {},
        "Also, if you want to read more about TaskTorch on our support site, or if you have "
        "questions to ask or feedback to share, click here!"

}

module.exports = OrgMenuCallout
