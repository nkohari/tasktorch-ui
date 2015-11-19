#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{span}    = React.DOM
#--------------------------------------------------------------------------------

Currency = React.createClass {

  displayName: 'Currency'

  propTypes:
    value: PropTypes.number

  render: ->

    span {className: 'currency'},
      "$#{(@props.value / 100).toFixed(2).toLocaleString()}"

}

module.exports = Currency
