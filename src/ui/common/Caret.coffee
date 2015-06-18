#--------------------------------------------------------------------------------
React  = require 'react'
{span} = React.DOM
#--------------------------------------------------------------------------------
require 'common/Caret.styl'
#--------------------------------------------------------------------------------

Caret = React.createClass {

  displayName: 'Caret'

  render: ->
    span {className: 'caret'}

}

module.exports = Caret
