#--------------------------------------------------------------------------------
React                  = require 'react/addons'
PropTypes              = require 'ui/framework/PropTypes'
{a, div, img, p, span} = React.DOM
#--------------------------------------------------------------------------------
require './WalkthroughOutro.styl'
#--------------------------------------------------------------------------------

WalkthroughOutro = React.createClass {

  displayName: 'WalkthroughOutro'

  propTypes:
    complete: PropTypes.func

  render: ->

    div {className: 'walkthrough-outro'},
      img {className: 'flicker', src: require('img/flicker-waving.svg')}
      p {},
        "Congratulations! You're ready to start coordinating your work with TaskTorch."
      p {},
        "We'd love to know what you think, what works, and what doesn't. "
        "And of course, if you run into any trouble, or have any questions, "
        "we're always here for you!"
      a {className: 'complete', onClick: @props.complete},
        "Let's get started!"

}

module.exports = WalkthroughOutro
