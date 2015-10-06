#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Callout   = React.createFactory(require 'ui/walkthrough/Callout')
{p}       = React.DOM
#--------------------------------------------------------------------------------

ExpandedCardCallout = React.createClass {

  displayName: 'ExpandedCardCallout'

  render: ->
    
    Callout {selector: '.card.panel', position: 'top left'},
      p {},
        "You can click a card in any column to open the expanded version, which "
        "has all the context you need to get the work done. No more searching through "
        "a bunch of tools to find what you're looking for!"

}

module.exports = ExpandedCardCallout
