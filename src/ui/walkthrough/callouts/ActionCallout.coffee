#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Callout   = React.createFactory(require 'ui/walkthrough/Callout')
{p, em}   = React.DOM
#--------------------------------------------------------------------------------

ActionCallout = React.createClass {

  displayName: 'ActionCallout'

  render: ->

    Callout {selector: '.card-actions-tab', position: 'top left'},
      p {},
        "All cards have a list of actions that need to be completed. If a card is a problem "
        "that needs to be solved, the card's actions are the steps in the solution."
      p {},
        "Actions are grouped into "
        em {}, "stages"
        ", in this case Setup, Learn, and Next Steps. Actions on two different cards of the same kind might differ, "
        "but all cards of the same kind have the same stages. "
        "When you create your own kinds, you can define whatever stages you want."
      p {},
        "We use these stages on the Big Picture screen to give you a quick view of "
        "how far cards are from being finished."

}

module.exports = ActionCallout
