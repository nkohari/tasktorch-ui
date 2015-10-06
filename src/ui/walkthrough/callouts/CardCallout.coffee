#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Callout   = React.createFactory(require 'ui/walkthrough/Callout')
{em, p}   = React.DOM
#--------------------------------------------------------------------------------

CardCallout = React.createClass {

  displayName: 'CardCallout'

  render: ->

    Callout {selector: '.stack-card', position: 'below left'},
      p {},
        "This is a "
        em {}, "card"
        ". It represents something that your company wants to accomplish, or a problem "
        "that you need to solve together."
      p {},
        "I created this card for you, so you can see all the great things you can do with TaskTorch!"

}

module.exports = CardCallout
