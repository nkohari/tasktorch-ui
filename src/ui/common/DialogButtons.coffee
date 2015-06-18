#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{div}     = React.DOM
#--------------------------------------------------------------------------------

# TODO: Could this be part of Dialog, e.g. Dialog.Buttons?

DialogButtons = React.createClass {

  displayName: 'DialogButtons'

  render: ->

    div {className: 'dialog-buttons'},
      @props.children

}

module.exports = DialogButtons
