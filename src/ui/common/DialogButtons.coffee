React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{div}     = React.DOM

DialogButtons = React.createClass {

  displayName: 'DialogButtons'

  render: ->

    div {className: 'dialog-buttons'},
      @props.children

}

module.exports = DialogButtons
