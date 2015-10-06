#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Callout   = React.createFactory(require 'ui/walkthrough/Callout')
{p, em}   = React.DOM
#--------------------------------------------------------------------------------
require './BigPictureCallout.styl'
#--------------------------------------------------------------------------------

BigPictureCallout = React.createClass {

  displayName: 'BigPictureCallout'

  render: ->

    Callout {className: 'big-picture-callout', selector: '.navigation .bigpicture', position: 'below right'},
      p {},
        "If you want to keep up with what everyone else is doing, you can switch "
        "to the Big Picture view by clicking here. You can see the status of cards "
        "organized by kind, team, or goal."

}

module.exports = BigPictureCallout
