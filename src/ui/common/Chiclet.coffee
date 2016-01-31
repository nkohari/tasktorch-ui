#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{div}     = React.DOM
#--------------------------------------------------------------------------------
require './Chiclet.styl'
#--------------------------------------------------------------------------------

Chiclet = React.createClass {

  displayName: 'Chiclet'

  render: ->

    div {className: 'chiclet'},
      @props.children

}

module.exports = Chiclet
