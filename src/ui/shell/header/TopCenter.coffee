#--------------------------------------------------------------------------------
React      = require 'react'
Navigation = React.createFactory(require 'ui/shell/header/Navigation')
{div}      = React.DOM
#--------------------------------------------------------------------------------
require './TopCenter.styl'
#--------------------------------------------------------------------------------

TopCenter = React.createClass {

  displayName: 'TopCenter'

  render: ->

    div {className: 'top-center'},
      Navigation {}

}

module.exports = TopCenter
