#--------------------------------------------------------------------------------
React     = require 'react/addons'
PropTypes = require 'ui/framework/PropTypes'
Callout   = React.createFactory(require 'ui/walkthrough/Callout')
{p, em}   = React.DOM
#--------------------------------------------------------------------------------

CardKindCallout = React.createClass {

  displayName: 'CardKindCallout'

  render: ->

    Callout {selector: '.card.panel .panel-header', position: 'below left'},
      p {},
        "Cards come in different "
        em {}, "kinds"
        ". This card is an Onboarding Example, a kind I created just for this walkthrough."
      p {},
        "You can make your own kinds to represent all the different "
        em {}, "kinds"
        " of work that you do. For example, you might have a kind for customer questions, and "
        "one for features that you want to build. It's totally up to you!"

}

module.exports = CardKindCallout
