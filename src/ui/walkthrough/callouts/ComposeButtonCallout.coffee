#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Callout   = React.createFactory(require 'ui/walkthrough/Callout')
{p, em}   = React.DOM
#--------------------------------------------------------------------------------

ComposeButtonCallout = React.createClass {

  displayName: 'ComposeButtonCallout'

  render: ->

    Callout {selector: '.compose', position: 'below left', forceSize: false},
      p {},
        "To create cards of your own, click the Compose button here and choose a kind. "
        "When you create a card, it begins in your "
        em {}, "drafts"
        " stack. After adding a description and actions, "
        "you can pass the card to someone, or accept it to begin working on it yourself."

}

module.exports = ComposeButtonCallout
