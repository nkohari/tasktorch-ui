React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{div}     = React.DOM

FieldGroup = React.createClass {

  displayName: 'FieldGroup'

  render: ->

    div {className: 'field-group'},
      @props.children

}

module.exports = FieldGroup
