#--------------------------------------------------------------------------------
React               = require 'react'
{div, img, p, span} = React.DOM
#--------------------------------------------------------------------------------
require './WalkthroughIntro.styl'
#--------------------------------------------------------------------------------

WalkthroughIntro = React.createClass {

  displayName: 'WalkthroughIntro'

  render: ->

    div {className: 'walkthrough-intro'},
      img {className: 'flicker', src: require('img/flicker-sitting.svg')}
      p {}, "Hi, I'm Flicker, your TaskTorch tour guide!"
      p {}, "I'll walk you through the basics and help you get started using our system. Don't worry, it'll only take a minute or two."
      p {}, "Click the arrow at the bottom right to advance."

}

module.exports = WalkthroughIntro
