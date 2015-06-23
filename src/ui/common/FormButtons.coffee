#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{div}     = React.DOM
#--------------------------------------------------------------------------------

# TODO: Could this be part of Form, e.g. Form.Buttons?

FormButtons = React.createClass {

  displayName: 'FormButtons'

  render: ->

    div {className: 'form-buttons'},
      @props.children

}

module.exports = FormButtons
